import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'core/theme/app_theme.dart';
import 'core/providers/core_providers.dart';

import 'features/dashboard/dashboard_screen.dart';
import 'features/dashboard/dashboard_provider.dart';
import 'features/crm/crm_screen.dart';
import 'features/inventory/inventory_screen.dart';
import 'features/orders/orders_screen.dart';
import 'features/finance/finance_screen.dart';

import 'domain/models/client.dart';
import 'domain/models/order.dart';
import 'domain/models/order_line_item.dart';
import 'domain/models/inventory_item.dart';
import 'domain/models/stock_movement.dart';
import 'domain/models/transaction.dart';

// ==========================================
// BACKGROUND ISOLATE ENGINE
// ==========================================
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          ClientSchema,
          InventoryItemSchema,
          OrderSchema,
          OrderLineItemSchema,
          StockMovementSchema,
          TransactionSchema
        ],
        directory: dir.path,
      );

      final unpaidOrdersCount =
          await isar.orders.filter().statusEqualTo('Delivered').count();

      if (unpaidOrdersCount > 0) {
        final flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        const AndroidInitializationSettings initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/launcher_icon');
        const InitializationSettings initializationSettings =
            InitializationSettings(android: initializationSettingsAndroid);

        // --- THE FIX: Modern named parameter 'settings:' ---
        await flutterLocalNotificationsPlugin.initialize(
          settings: initializationSettings,
        );

        const AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'payment_alerts',
          'Payment Alerts',
          importance: Importance.max,
          priority: Priority.high,
        );
        const NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        // --- THE FIX: Modern named parameters for 'show' ---
        await flutterLocalNotificationsPlugin.show(
          id: 0,
          title: 'Pending Payments',
          body:
              'You have $unpaidOrdersCount unpaid delivered orders. Tap to collect!',
          notificationDetails: platformChannelSpecifics,
        );
      }

      await isar.close();
      return true;
    } catch (e) {
      return false;
    }
  });
}

// ==========================================
// MAIN APP LAUNCH
// ==========================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  Workmanager().registerPeriodicTask(
    "daily-payment-check",
    "checkPendingPayments",
    frequency: const Duration(hours: 24),
    // --- THE FIX: Removed the invalid NetworkType.not_required ---
    constraints: Constraints(
      requiresBatteryNotLow: true,
    ),
  );

  final dir = await getApplicationDocumentsDirectory();
  final isarInstance = await Isar.open(
    [
      ClientSchema,
      InventoryItemSchema,
      OrderSchema,
      OrderLineItemSchema,
      StockMovementSchema,
      TransactionSchema
    ],
    directory: dir.path,
  );

  runApp(
    ProviderScope(
      overrides: [isarProvider.overrideWithValue(isarInstance)],
      child: const SoloBusinessApp(),
    ),
  );
}

class SoloBusinessApp extends StatelessWidget {
  const SoloBusinessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solo CRM & ERP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends ConsumerStatefulWidget {
  const MainNavigationShell({super.key});

  @override
  ConsumerState<MainNavigationShell> createState() =>
      _MainNavigationShellState();
}

class _MainNavigationShellState extends ConsumerState<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const CRMScreen(),
    const OrdersScreen(),
    const InventoryScreen(),
    const FinanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final pendingCountAsync = ref.watch(pendingActionCountProvider);
    final pendingCount = pendingCountAsync.value ?? 0;

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.surfaceDark,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: pendingCount > 0,
                label: Text(pendingCount.toString()),
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.dashboard_outlined),
              ),
              activeIcon: Badge(
                isLabelVisible: pendingCount > 0,
                label: Text(pendingCount.toString()),
                backgroundColor: Colors.redAccent,
                child: const Icon(Icons.dashboard),
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'CRM'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Orders'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'Inventory'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Finance'),
        ],
      ),
    );
  }
}
