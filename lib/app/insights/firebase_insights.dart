// Firebase-backed insights. Layout in Firestore (one folder per phone):
//
//   devices/{uid}                         phone: app version, language, last seen
//   devices/{uid}/sessions/{sessionId}    one app launch
//       .../events/{auto}                 a batch of up to 300 screen / tap / save events
//   devices/{uid}/snapshots/{stamp}       a data copy (reason, counts)
//       .../tables/{shop_table_part}      rows of one table (real or practice shop)
//
// Security rules let each phone write only its own folder. Crashes go to
// Crashlytics. Firestore queues writes while offline and sends them later.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../../data/database.dart';
import 'insights.dart';
import 'snapshot.dart';

const appVersion = '1.0.0';

class FirebaseInsights with InsightRecorder {
  FirebaseInsights._(this._shops);

  /// The real and practice databases (read for snapshots).
  final Map<String, AppDatabase Function()> _shops;
  @override
  final buffer = InsightBuffer();
  final _sessionId = DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
  bool _enabled = false;
  bool _sessionWritten = false;
  Timer? _timer;
  String? _uid;

  /// Starts Firebase (collection stays off until [setEnabled]). Returns
  /// [NoInsights] if Firebase cannot start, so the app always works.
  static Future<Insights> start({required Map<String, AppDatabase Function()> shops}) async {
    try {
      await Firebase.initializeApp();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      return FirebaseInsights._(shops);
    } catch (e) {
      debugPrint('Insights unavailable: $e');
      return NoInsights();
    }
  }

  @override
  bool get enabled => _enabled;

  @override
  Future<void> setEnabled(bool on) async {
    if (on == _enabled) return;
    _enabled = on;
    try {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(on);
    } catch (_) {}
    _timer?.cancel();
    if (on) {
      _timer = Timer.periodic(const Duration(minutes: 1), (_) => flush());
      event('insights_on');
      unawaited(flush());
    }
  }

  /// Signs the phone in anonymously (needs internet once).
  Future<String?> _deviceId() async {
    if (_uid != null) return _uid;
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser ?? (await auth.signInAnonymously()).user;
      _uid = user?.uid;
      if (_uid != null) await FirebaseCrashlytics.instance.setUserIdentifier(_uid!);
    } catch (e) {
      debugPrint('Insights sign-in failed (will retry): $e');
    }
    return _uid;
  }

  DocumentReference<Map<String, dynamic>> _device(String uid) =>
      FirebaseFirestore.instance.collection('devices').doc(uid);

  @override
  Future<void> flush() async {
    if (!_enabled || buffer.length == 0) return;
    final uid = await _deviceId();
    if (uid == null) return; // offline before first sign-in; keep buffering
    final batches = buffer.drain();
    try {
      final device = _device(uid);
      final session = device.collection('sessions').doc(_sessionId);
      if (!_sessionWritten) {
        await device.set({
          'appVersion': appVersion,
          'platform': defaultTargetPlatform.name,
          'lastSeen': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        await session.set({'startedAt': FieldValue.serverTimestamp(), 'appVersion': appVersion});
        _sessionWritten = true;
      } else {
        await device.set({'lastSeen': FieldValue.serverTimestamp()}, SetOptions(merge: true));
      }
      for (final b in batches) {
        await session.collection('events').add({
          'sentAt': FieldValue.serverTimestamp(),
          'from': b.first.at.toIso8601String(),
          'to': b.last.at.toIso8601String(),
          'events': [for (final e in b) e.toJson()],
        });
      }
    } catch (e) {
      debugPrint('Insights upload failed (will retry): $e');
      buffer.restore([for (final b in batches) ...b]);
    }
  }

  @override
  Future<bool> sendSnapshot({required String reason}) async {
    if (!_enabled) return false;
    final uid = await _deviceId();
    if (uid == null) return false;
    try {
      final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(':', '-');
      final snap = _device(uid).collection('snapshots').doc(stamp);
      final counts = <String, int>{};
      // Firestore allows at most 500 writes per batch: commit every 400.
      var batch = FirebaseFirestore.instance.batch();
      var inBatch = 0;
      var writes = 0;
      Future<void> put(DocumentReference<Map<String, dynamic>> ref, Map<String, Object?> data) async {
        batch.set(ref, data);
        writes++;
        if (++inBatch >= 400) {
          await batch.commit();
          batch = FirebaseFirestore.instance.batch();
          inBatch = 0;
        }
      }

      for (final MapEntry(key: shop, value: open) in _shops.entries) {
        final tables = await exportTables(open());
        for (final MapEntry(key: table, value: rows) in tables.entries) {
          counts['$shop.$table'] = rows.length;
          for (final (i, chunk) in chunkRows(rows).indexed) {
            await put(snap.collection('tables').doc('${shop}_${table}_$i'),
                {'shop': shop, 'table': table, 'part': i, 'rows': chunk});
          }
        }
      }
      // The summary goes last, so a snapshot that has a summary is complete.
      batch.set(snap, {
        'reason': reason,
        'createdAt': FieldValue.serverTimestamp(),
        'appVersion': appVersion,
        'rowCounts': counts,
        'documents': writes,
      });
      await batch.commit();
      event('snapshot_sent', {'reason': reason});
      return true;
    } catch (e) {
      debugPrint('Snapshot failed: $e');
      return false;
    }
  }

  /// Crashes and errors outside Flutter's own handlers.
  void recordError(Object error, StackTrace stack, {bool fatal = false}) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
  }

  void recordFlutterError(FlutterErrorDetails details) {
    if (!_enabled) return;
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
  }
}
