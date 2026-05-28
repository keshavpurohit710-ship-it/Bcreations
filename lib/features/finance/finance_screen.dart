import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'finance_provider.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  void _showAddTransactionForm(BuildContext context, WidgetRef ref) {
    final descController = TextEditingController();
    final amountController = TextEditingController();
    String selectedType = 'Income';
    String selectedCategory = 'Sales';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('New Transaction',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: descController,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle:
                          const TextStyle(color: AppTheme.textSecondary),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.accentAmber),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Amount (₹)',
                      labelStyle:
                          const TextStyle(color: AppTheme.textSecondary),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.textSecondary),
                          borderRadius: BorderRadius.circular(8)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppTheme.accentAmber),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppTheme.cardColor,
                          initialValue: selectedType,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Type',
                            labelStyle:
                                const TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: ['Income', 'Expense']
                              .map((String value) => DropdownMenuItem(
                                  value: value, child: Text(value)))
                              .toList(),
                          onChanged: (newValue) => setModalState(() {
                            selectedType = newValue!;
                            selectedCategory = selectedType == 'Income'
                                ? 'Sales'
                                : 'Procurement'; // Auto-switch category based on type
                          }),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          dropdownColor: AppTheme.cardColor,
                          initialValue: selectedCategory,
                          style: const TextStyle(color: AppTheme.textPrimary),
                          decoration: InputDecoration(
                            labelText: 'Category',
                            labelStyle:
                                const TextStyle(color: AppTheme.textSecondary),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          items: (selectedType == 'Income'
                                  ? ['Sales', 'Other']
                                  : ['Procurement', 'Logistics', 'Overhead'])
                              .map((String value) => DropdownMenuItem(
                                  value: value, child: Text(value)))
                              .toList(),
                          onChanged: (newValue) =>
                              setModalState(() => selectedCategory = newValue!),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentAmber,
                        foregroundColor: AppTheme.bgColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        if (descController.text.isNotEmpty &&
                            amountController.text.isNotEmpty) {
                          ref.read(financeProvider.notifier).addTransaction(
                                descController.text,
                                double.tryParse(amountController.text) ?? 0.0,
                                selectedType,
                                selectedCategory,
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save Transaction',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(financeProvider);

    // Calculate totals dynamically
    double totalIncome = 0;
    double totalExpense = 0;
    for (var txn in transactions) {
      if (txn.type == 'Income') totalIncome += txn.amount;
      if (txn.type == 'Expense') totalExpense += txn.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial Ledger'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppTheme.accentAmber),
            onPressed: () => _showAddTransactionForm(context, ref),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Monthly Summary Board
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                    child: _buildSummaryCard(
                        title: 'Money In',
                        amount: '₹$totalIncome',
                        icon: Icons.arrow_downward,
                        color: AppTheme.statusSuccess)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildSummaryCard(
                        title: 'Money Out',
                        amount: '₹$totalExpense',
                        icon: Icons.arrow_upward,
                        color: AppTheme.statusDanger)),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Transactions',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 8),

          // Ledger List
          Expanded(
            child: transactions.isEmpty
                ? const Center(
                    child: Text('No transactions yet.',
                        style: TextStyle(color: AppTheme.textSecondary)))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final txn = transactions[index];
                      final isIncome = txn.type == 'Income';

                      return Card(
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          leading: CircleAvatar(
                            backgroundColor: isIncome
                                ? AppTheme.statusSuccess.withOpacity(0.2)
                                : AppTheme.statusDanger.withOpacity(0.2),
                            child: Icon(isIncome ? Icons.add : Icons.remove,
                                color: isIncome
                                    ? AppTheme.statusSuccess
                                    : AppTheme.statusDanger),
                          ),
                          title: Text(txn.description ?? '',
                              style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14)),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                                '${txn.date?.toLocal().toString().split(' ')[0]} • ${txn.category}',
                                style: const TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12)),
                          ),
                          trailing: Text(
                            '${isIncome ? '+' : '-'}₹${txn.amount}',
                            style: TextStyle(
                              color: isIncome
                                  ? AppTheme.statusSuccess
                                  : AppTheme.statusDanger,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      {required String title,
      required String amount,
      required IconData icon,
      required Color color}) {
    return Card(
      color: color.withOpacity(0.1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: color.withOpacity(0.5), width: 1)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 16),
                const SizedBox(width: 4),
                Text(title,
                    style: TextStyle(
                        color: color,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 12),
            Text(amount,
                style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
