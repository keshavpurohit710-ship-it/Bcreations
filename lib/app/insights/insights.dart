// Remote insights: what screens she uses, where she taps, what she saves,
// crashes, and a copy of her data — so problems can be understood from afar.
// Nothing is collected unless she agreed on the consent screen.

/// One thing that happened in the app.
class InsightEvent {
  InsightEvent(this.kind, this.name, {this.screen, this.data = const {}, DateTime? at})
      : at = at ?? DateTime.now();

  /// 'screen' | 'tap' | 'save' | 'event'
  final String kind;
  final String name;

  /// The screen it happened on (for taps and actions).
  final String? screen;
  final Map<String, Object?> data;
  final DateTime at;

  Map<String, Object?> toJson() => {
        't': at.toIso8601String(),
        'k': kind,
        'n': name,
        if (screen != null) 's': screen,
        if (data.isNotEmpty) 'd': data,
      };
}

/// Holds events until they are uploaded, in batches that fit one document.
class InsightBuffer {
  InsightBuffer({this.maxPerBatch = 300, this.maxKept = 5000});
  final int maxPerBatch;

  /// If the phone is offline for days, keep only the newest events.
  final int maxKept;
  final _events = <InsightEvent>[];

  int get length => _events.length;

  void add(InsightEvent e) {
    _events.add(e);
    if (_events.length > maxKept) _events.removeRange(0, _events.length - maxKept);
  }

  /// Removes and returns everything, split into upload-sized batches.
  List<List<InsightEvent>> drain() {
    final batches = <List<InsightEvent>>[];
    for (var i = 0; i < _events.length; i += maxPerBatch) {
      batches.add(_events.sublist(i, i + maxPerBatch > _events.length ? _events.length : i + maxPerBatch));
    }
    _events.clear();
    return batches;
  }

  /// Puts events back at the front if an upload failed.
  void restore(List<InsightEvent> events) => _events.insertAll(0, events);
}

/// What the app calls. [NoInsights] does nothing (tests, or no consent).
abstract class Insights {
  bool get enabled;
  Future<void> setEnabled(bool on);
  void screen(String name);
  void tap(String screen, double xFraction, double yFraction);
  void save(String table, String kind);
  void event(String name, [Map<String, Object?> data = const {}]);
  Future<void> flush();

  /// Uploads a copy of the shop data. Returns false if it could not be queued.
  Future<bool> sendSnapshot({required String reason});
}

class NoInsights implements Insights {
  @override
  bool get enabled => false;
  @override
  Future<void> setEnabled(bool on) async {}
  @override
  void screen(String name) {}
  @override
  void tap(String screen, double xFraction, double yFraction) {}
  @override
  void save(String table, String kind) {}
  @override
  void event(String name, [Map<String, Object?> data = const {}]) {}
  @override
  Future<void> flush() async {}
  @override
  Future<bool> sendSnapshot({required String reason}) async => false;
}
