import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';
import 'core/theme/app_theme.dart';
import 'features/dashboard/dashboard_screen.dart';

// 1. UPDATED IMPORTS: Pointing to the new Domain Models
import 'domain/models/client.dart';
import 'domain/models/order.dart';
import 'domain/models/order_line_item.dart';
import 'domain/models/inventory_item.dart';
import 'domain/models/stock_movement.dart';
import 'domain/models/transaction.dart';

// 2. FEATURE IMPORTS
import 'features/crm/crm_screen.dart';
import 'features/inventory/inventory_screen.dart';
import 'features/orders/orders_screen.dart';
import 'features/finance/finance_screen.dart';

late Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  // 3. REGISTER ALL 6 SCHEMAS
  isar = await Isar.open(
    [
      ClientSchema,
      OrderSchema,
      OrderLineItemSchema, // NEW
      InventoryItemSchema,
      StockMovementSchema, // NEW
      TransactionSchema
    ],
    directory: dir.path,
  );

  runApp(const ProviderScope(child: SoloBusinessApp()));
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

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const DashboardScreen(),
    const CRMScreen(),
    const OrdersScreen(),
    const InventoryScreen(),
    const FinanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed, // Keeps icons visible
        backgroundColor: AppTheme.surfaceDark,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people),
              label: 'CRM'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long),
              label: 'Orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2),
              label: 'Inventory'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet_outlined),
              activeIcon: Icon(Icons.account_balance_wallet),
              label: 'Finance'),
        ],
      ),
    );
  }
}
