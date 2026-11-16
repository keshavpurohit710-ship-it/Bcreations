// Renders every main screen to PNG (build/screens/) with real fonts, so colours,
// sizes and cut-off text can be checked by eye without a phone.
// Run:  CAPTURE=1 flutter test test/visual/capture_screens_test.dart
// Skipped in normal test runs and CI.

import 'dart:io';
import 'dart:ui' as ui;

import 'package:bcreations/app/app.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/features/customers/customer_detail_screen.dart';
import 'package:bcreations/features/items/item_detail_screen.dart';
import 'package:bcreations/features/items/item_form_screen.dart';
import 'package:bcreations/features/orders/order_detail_screen.dart';
import 'package:bcreations/features/orders/order_form_screen.dart';
import 'package:bcreations/features/settings/settings_screen.dart';
import 'package:bcreations/features/tutorial/tour_screen.dart';
import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../app_harness.dart';

final _capture = Platform.environment.containsKey('CAPTURE');
final _boundary = GlobalKey();

Future<void> _loadFonts() async {
  final sdk = Platform.environment['FLUTTER_ROOT'] ?? '${Platform.environment['USERPROFILE']}/flutter';
  final dir = '$sdk/bin/cache/artifacts/material_fonts';
  final roboto = FontLoader('Roboto');
  for (final f in ['roboto-regular.ttf', 'roboto-medium.ttf', 'roboto-bold.ttf']) {
    roboto.addFont(Future.value(ByteData.sublistView(File('$dir/$f').readAsBytesSync())));
  }
  await roboto.load();
  final icons = FontLoader('MaterialIcons')
    ..addFont(Future.value(ByteData.sublistView(File('$dir/materialicons-regular.otf').readAsBytesSync())));
  await icons.load();
}

Future<void> _settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

Future<void> _shot(WidgetTester tester, String name) async {
  final boundary = _boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  final bytes = await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 1.0);
    return (await image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  });
  final file = File('build/screens/$name.png')..createSync(recursive: true);
  file.writeAsBytesSync(bytes!);
}

void main() {
  testWidgets('capture screens', skip: !_capture, timeout: const Timeout(Duration(minutes: 5)), (tester) async {
    await tester.runAsync(_loadFonts);
    tester.view.physicalSize = const Size(393, 851); // phone in dp, 1:1
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    final db = (await tester.runAsync(() async {
      final db = AppDatabase(NativeDatabase.memory());
      await loadDemo(db, languageCode: 'en');
      return db;
    }))!;
    await tester.pumpWidget(ProviderScope(
      overrides: TestShops(db).overrides,
      child: RepaintBoundary(key: _boundary, child: const BcApp()),
    ));
    await _settle(tester);
    await _shot(tester, '01_home');

    for (final (i, name, icon) in [
      (2, 'orders', Icons.receipt_long_outlined),
      (3, 'customers', Icons.people_outline),
      (4, 'items', Icons.inventory_2_outlined),
      (5, 'money', Icons.account_balance_wallet_outlined),
    ]) {
      await tester.tap(find.byIcon(icon).last);
      await _settle(tester);
      await _shot(tester, '0${i}_$name');
    }
    await tester.tap(find.byIcon(Icons.home_outlined).last);
    await _settle(tester);

    final ids = (await tester.runAsync(() async => (
          order:
              (await (db.select(db.orders)..where((o) => o.status.equalsValue(OrderStatus.confirmed))).get()).first.id,
          delivered:
              (await (db.select(db.orders)..where((o) => o.status.equalsValue(OrderStatus.delivered))).get()).first.id,
          party: (await (db.select(db.parties)..where((p) => p.name.equals('Rang Boutique'))).getSingle()).id,
          asha: (await (db.select(db.parties)..where((p) => p.name.equals('Asha Mehta'))).getSingle()).id,
          made: (await (db.select(db.products)..where((p) => p.name.equals('Silk potli bag'))).getSingle()).id,
        )))!;
    final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
    Future<void> open(String name, Widget screen, {Future<void> Function()? then}) async {
      nav.push(MaterialPageRoute(builder: (_) => screen));
      await _settle(tester);
      if (then != null) {
        await then();
        await _settle(tester);
      }
      await _shot(tester, name);
      nav.popUntil((r) => r.isFirst);
      await _settle(tester);
    }

    await open('10_order_detail_open', OrderDetailScreen(orderId: ids.order));
    await open('11_order_detail_delivered', OrderDetailScreen(orderId: ids.delivered));
    await open('12_order_form', OrderFormScreen(partyId: ids.asha), then: () async {
      await tester.tap(find.text('Add item'));
      await _settle(tester);
      await tester.tap(find.text('Kundan rakhi'));
    });
    await open('13_customer_detail', CustomerDetailScreen(partyId: ids.party));
    await open('14_item_detail', ItemDetailScreen(productId: ids.made));
    await open('15_item_form_new', const ItemFormScreen());
    await open('16_settings', const SettingsScreen());

    // Bottom sheets from the ＋ button
    await tester.tap(find.text('Add'));
    await _settle(tester);
    await _shot(tester, '20_quick_add');
    await tester.tap(find.text('Payment received'));
    await _settle(tester);
    await _shot(tester, '21_payment_sheet');
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('capture first-run and tutorial screens', skip: !_capture, timeout: const Timeout(Duration(minutes: 5)),
      (tester) async {
    await tester.runAsync(_loadFonts);
    tester.view.physicalSize = const Size(393, 851);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    final db = AppDatabase(NativeDatabase.memory());
    await tester.runAsync(() => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
        .write(const SettingsCompanion(languageCode: Value('en'))));
    await tester.pumpWidget(ProviderScope(
      overrides: TestShops(db).overrides,
      child: RepaintBoundary(key: _boundary, child: const BcApp()),
    ));
    await _settle(tester);
    await _shot(tester, '30_welcome');
    await tester.tap(find.text('Learn in 5 minutes with a practice shop'));
    await _settle(tester);
    await _shot(tester, '31_practice_step1');
    await tester.tap(find.text('Show me'));
    await _settle(tester);
    await _shot(tester, '32_practice_show_me');
    tester.state<NavigatorState>(find.byType(Navigator).first).popUntil((r) => r.isFirst);
    await _settle(tester);
    tester.state<NavigatorState>(find.byType(Navigator).first)
        .push(MaterialPageRoute(builder: (_) => const FeatureTourScreen()));
    await _settle(tester);
    await _shot(tester, '33_tour');
    tester.state<NavigatorState>(find.byType(Navigator).first)
        .push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
    await _settle(tester);
    await tester.drag(find.byType(ListView).last, const Offset(0, -700));
    await _settle(tester);
    await _shot(tester, '34_settings_learning');
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 1));
  });
}
