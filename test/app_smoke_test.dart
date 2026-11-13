// Boots the real app on an in-memory database with demo data and opens every
// tab, in English and Hindi. Catches layout overflows and crashes in screens.

import 'package:bcreations/app/app.dart';
import 'package:bcreations/app/providers.dart';
import 'package:bcreations/data/database.dart';
import 'package:bcreations/features/customers/customer_detail_screen.dart';
import 'package:bcreations/features/customers/customer_form_screen.dart';
import 'package:bcreations/features/items/item_detail_screen.dart';
import 'package:bcreations/features/items/item_form_screen.dart';
import 'package:bcreations/features/orders/order_detail_screen.dart';
import 'package:bcreations/features/orders/order_form_screen.dart';
import 'package:bcreations/features/settings/settings_screen.dart';
import 'package:drift/drift.dart' show Value, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const _timeout = Timeout(Duration(minutes: 2));

void _phoneSize(WidgetTester tester) {
  // A typical 6.4" Android phone (393 × 851 dp)
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 2.75;
  addTearDown(tester.view.reset);
}

Future<void> _settle(WidgetTester tester) async {
  // Let database futures resolve, then frames render.
  for (var i = 0; i < 6; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 60)));
    await tester.pump();
  }
}

/// Fails with the widget that caused a layout error, if any.
void _expectNoLayoutError(WidgetTester tester, String where) {
  final e = tester.takeException();
  if (e == null) return;
  final details = e is FlutterError ? e.diagnostics.map((d) => d.toString()).join('\n') : '$e';
  fail('$where: $details');
}

/// Unmounts the app and lets pending database timers finish.
Future<void> _tearDown(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  for (final lang in ['en', 'hi']) {
    testWidgets('every tab renders with demo data ($lang)', timeout: _timeout, (tester) async {
      _phoneSize(tester);
      final db = (await tester.runAsync(() async {
        final db = AppDatabase(NativeDatabase.memory());
        await loadDemo(db, languageCode: lang);
        return db;
      }))!;
      await tester.pumpWidget(ProviderScope(overrides: [databaseProvider.overrideWithValue(db)], child: const BcApp()));
      await _settle(tester);
      _expectNoLayoutError(tester, 'Home');
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.textContaining('₹'), findsWidgets);

      for (final (name, icon) in [
        ('Orders', Icons.receipt_long_outlined),
        ('Customers', Icons.people_outline),
        ('Items', Icons.inventory_2_outlined),
        ('Money', Icons.account_balance_wallet_outlined),
        ('Home', Icons.home_outlined),
      ]) {
        await tester.tap(find.byIcon(icon).last);
        await _settle(tester);
        _expectNoLayoutError(tester, name);
      }

      await tester.tap(find.byIcon(Icons.add).first);
      await _settle(tester);
      _expectNoLayoutError(tester, 'Quick add');
      expect(find.byType(ListTile), findsWidgets);

      await _tearDown(tester);
    });
  }

  testWidgets('first launch shows the welcome screen', timeout: _timeout, (tester) async {
    _phoneSize(tester);
    final db = AppDatabase(NativeDatabase.memory());
    await tester.runAsync(() => (db.update(db.settings)..where((s) => s.id.equals(settingsRowId)))
        .write(const SettingsCompanion(languageCode: Value('en'))));
    await tester.pumpWidget(ProviderScope(overrides: [databaseProvider.overrideWithValue(db)], child: const BcApp()));
    await _settle(tester);
    _expectNoLayoutError(tester, 'Welcome');
    expect(find.text('Start fresh'), findsOneWidget);
    expect(find.text('Try with sample data'), findsOneWidget);
    await _tearDown(tester);
  });

  for (final lang in ['en', 'hi']) {
    testWidgets('detail screens and forms render ($lang)', timeout: _timeout, (tester) async {
      _phoneSize(tester);
      final db = (await tester.runAsync(() async {
        final db = AppDatabase(NativeDatabase.memory());
        await loadDemo(db, languageCode: lang);
        return db;
      }))!;
      final ids = (await tester.runAsync(() async => (
            order: (await db.select(db.orders).get()).first.id,
            customOrder: (await (db.select(db.orders)..where((o) => o.status.equalsValue(OrderStatus.confirmed))).get())
                .first
                .id,
            party: (await db.select(db.parties).get()).firstWhere((p) => p.role == PartyRole.customer).id,
            made: (await db.select(db.products).get()).firstWhere((p) => p.kind == ProductKind.made).id,
          )))!;
      await tester.pumpWidget(ProviderScope(overrides: [databaseProvider.overrideWithValue(db)], child: const BcApp()));
      await _settle(tester);

      final screens = <String, Widget>{
        'Order detail': OrderDetailScreen(orderId: ids.order),
        'Order detail (open, advance)': OrderDetailScreen(orderId: ids.customOrder),
        'New order': const OrderFormScreen(),
        'Edit order': OrderFormScreen(orderId: ids.customOrder),
        'Customer detail': CustomerDetailScreen(partyId: ids.party),
        'Customer form': const CustomerFormScreen(),
        'Item detail': ItemDetailScreen(productId: ids.made),
        'Item form (edit)': ItemFormScreen(productId: ids.made),
        'Settings': const SettingsScreen(),
      };
      for (final MapEntry(key: name, value: screen) in screens.entries) {
        final nav = tester.state<NavigatorState>(find.byType(Navigator).first);
        nav.push(MaterialPageRoute(builder: (_) => screen));
        await _settle(tester);
        _expectNoLayoutError(tester, name);
        nav.pop();
        await _settle(tester);
      }
      await _tearDown(tester);
    });
  }
}
