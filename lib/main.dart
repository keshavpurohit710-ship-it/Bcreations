import 'models/inventory_item.dart';
import 'features/finance/finance_screen.dart';
import 'models/transaction.dart';
import 'features/orders/orders_screen.dart';
import 'models/order.dart';
import 'features/crm/crm_screen.dart';
import 'features/inventory/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart'; // <-- New import
import 'package:isar/isar.dart'; // <-- New import
import 'core/theme/app_theme.dart';
import 'models/client.dart'; // <-- New import

late Isar isar;

void main() async {
  // Ensure Flutter engine is ready
  WidgetsFlutterBinding.ensureInitialized();

  // Find the safe folder on your phone to store the database
  final dir = await getApplicationDocumentsDirectory();

  // Turn on the Isar Database and tell it about our Client blueprint
  isar = await Isar.open(
    [
      ClientSchema,
      InventoryItemSchema,
      OrderSchema,
      TransactionSchema
    ], // Add schemas here as we build them (Orders, Inventory, etc.)
    directory: dir.path,
  );

  // Run the app
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
      home: const MainNavigationShell(), // Brings back the nav bar!
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 1; // Default to CRM tab for now

  // We are slowly replacing these placeholders with our real database screens!
  final List<Widget> _pages = [
    const Center(
        child: Text('Dashboard Placeholder',
            style: TextStyle(color: AppTheme.textPrimary))),
    const CRMScreen(), // <-- Real CRM Database Screen
    const OrdersScreen(),
    const InventoryScreen(), // <-- Real Inventory Database Screen
    const FinanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
