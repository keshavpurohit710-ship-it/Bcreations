import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'finance_provider.dart';
import 'add_payment_screen.dart'; // <-- 1. Import the new form

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(recentTransactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Ledger'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: txAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (transactions) {
          // DYNAMIC MATH: Calculate Total Revenue on the fly
          final totalRevenue = transactions
              .where((tx) => tx.type == 'Income')
              .fold(0.0, (sum, tx) => sum + tx.amount);

          return Column(
            children: [
              // --- THE INTERPRETABLE SUMMARY DASHBOARD ---
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF1E1E2C), Color(0xFF2A2A3D)]),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.3)),
                ),
                child: Column(
                  children: [
                    const Text('Total Revenue Collected',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 8),
                    Text(
                      '₹${totalRevenue.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Recent Transactions',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold))),
              ),

              // --- THE LEDGER LIST ---
              Expanded(
                child: transactions.isEmpty
                    ? const Center(
                        child: Text('No transactions yet.',
                            style: TextStyle(color: Colors.grey)))
                    : ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                          final tx = transactions[index];
                          final isIncome = tx.type == 'Income';

                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            color: AppTheme.backgroundDark,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.2),
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isIncome
                                    ? Colors.green.withOpacity(0.2)
                                    : Colors.red.withOpacity(0.2),
                                child: Icon(
                                  isIncome
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                  color: isIncome
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                ),
                              ),
                              title: Text(tx.paymentMethod ?? 'Payment',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  'ID: #${tx.id} • ${tx.date?.toString().split(' ')[0] ?? ''}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12)),
                              trailing: Text(
                                '${isIncome ? '+' : '-'} ₹${tx.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: isIncome
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),

      // <-- 2. The New Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPaymentScreen()),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Record Payment',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
