import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../dashboard/dashboard_provider.dart';
import '../crm/crm_provider.dart'; // <--- Required to look up client names
import 'finance_provider.dart';
import 'add_payment_screen.dart';
import 'add_expense_screen.dart';

class FinanceScreen extends ConsumerWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revAsync = ref.watch(totalRevenueProvider);
    final expAsync = ref.watch(totalExpensesProvider);
    final profitAsync = ref.watch(netProfitProvider);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Financial Ledger & P&L'),
          backgroundColor: AppTheme.surfaceDark,
          // --- THE FIX: Sticky Search Bar injected before TabBar ---
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(116),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search ledger by client, method, or amount...',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      filled: true,
                      fillColor: AppTheme.backgroundDark,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                    onChanged: (value) => ref
                        .read(financeSearchQueryProvider.notifier)
                        .state = value,
                  ),
                ),
                const TabBar(
                  indicatorColor: Colors.blueAccent,
                  labelColor: Colors.blueAccent,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(icon: Icon(Icons.receipt), text: 'Transaction Log'),
                    Tab(
                        icon: Icon(Icons.analytics),
                        text: 'Monthly Performance'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            // --- STEP 4.1: CONSOLIDATED P&L SUMMARY MATRIX ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMetricColumn('Revenue', revAsync, Colors.greenAccent),
                  Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(0.3)),
                  _buildMetricColumn('Expenses', expAsync, Colors.orangeAccent),
                  Container(
                      width: 1,
                      height: 40,
                      color: Colors.grey.withOpacity(0.3)),
                  _buildMetricColumn(
                      'Net Profit', profitAsync, Colors.blueAccent),
                ],
              ),
            ),

            // --- STEP 4.2: EXPANDED VIEW LAYOUTS ---
            const Expanded(
              child: TabBarView(
                children: [
                  _TransactionTableList(),
                  _MonthlyAnalyticsDashboard(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            // --- Bottom Sheet logic preserved exactly as requested ---
            showModalBottomSheet(
              context: context,
              backgroundColor: AppTheme.surfaceDark,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              builder: (context) => SafeArea(
                child: Wrap(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Record Transaction',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_downward,
                          color: Colors.greenAccent),
                      title: const Text('Record Income',
                          style: TextStyle(color: Colors.white)),
                      subtitle: const Text('Client payments & invoice clearing',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddPaymentScreen()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.arrow_upward,
                          color: Colors.redAccent),
                      title: const Text('Record Expense',
                          style: TextStyle(color: Colors.white)),
                      subtitle: const Text('Rent, salaries, software, etc.',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const AddExpenseScreen()));
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMetricColumn(
      String label, AsyncValue<double> state, Color valueColor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        state.when(
          loading: () => const SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(strokeWidth: 2)),
          error: (_, __) =>
              const Text('Error', style: TextStyle(color: Colors.red)),
          data: (val) => Text('₹${val.toStringAsFixed(0)}',
              style: TextStyle(
                  color: valueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}

// ... NOTE: _TransactionTableList and _MonthlyAnalyticsDashboard remain below this.
// ==========================================
// VIEW: TRANSACTION TABLE LOG
// ==========================================
class _TransactionTableList extends ConsumerWidget {
  const _TransactionTableList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txAsync = ref.watch(recentTransactionsProvider);
    final clientsAsync =
        ref.watch(activeClientsProvider); // <-- Added clients provider

    return txAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (transactions) {
        if (transactions.isEmpty) {
          return const Center(
              child: Text('No entries found.',
                  style: TextStyle(color: Colors.grey)));
        }

        final clients = clientsAsync.value ?? [];

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final tx = transactions[index];
            final isIncome = tx.type == 'Income';

            // --- THE FIX: SMART TITLES ---
            String titleText = 'Unknown';
            if (!isIncome) {
              titleText = tx.paymentMethod ?? 'Expense';
            } else {
              final client =
                  clients.where((c) => c.id == tx.clientId).firstOrNull;
              titleText =
                  client?.businessName ?? client?.name ?? 'Unknown Client';
            }

            // --- THE FIX: SMART SUBTITLES ---
            String subtitleText = tx.date?.toString().split(' ')[0] ?? '';
            if (isIncome &&
                tx.paymentMethod != null &&
                tx.paymentMethod!.isNotEmpty) {
              subtitleText += ' • ${tx.paymentMethod}';
            }
            if (tx.description != null && tx.description!.isNotEmpty) {
              subtitleText += ' • ${tx.description}';
            }

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              color: AppTheme.backgroundDark,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isIncome
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  child: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color:
                          isIncome ? Colors.greenAccent : Colors.orangeAccent,
                      size: 18),
                ),
                title: Text(titleText,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                subtitle: Text(subtitleText,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
                trailing: Text(
                  '${isIncome ? '+' : '-'} ₹${tx.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                      color:
                          isIncome ? Colors.greenAccent : Colors.orangeAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ==========================================
// VIEW: MONTHLY PERFORMANCE DASHBOARD
// ==========================================
class _MonthlyAnalyticsDashboard extends ConsumerWidget {
  const _MonthlyAnalyticsDashboard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(monthlyAnalyticsProvider);

    return analyticsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (metricsList) {
        if (metricsList.isEmpty) {
          return const Center(
              child: Text('Insufficient historical trends.',
                  style: TextStyle(color: Colors.grey)));
        }

        return ListView.builder(
          itemCount: metricsList.length,
          itemBuilder: (context, index) {
            final performance = metricsList[index];
            final isProfitable = performance.netProfit >= 0;

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(performance.monthYear,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Billings:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹${performance.revenue.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.greenAccent, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Procurement Outlays:',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('₹${performance.expenses.toStringAsFixed(0)}',
                          style: const TextStyle(
                              color: Colors.orangeAccent, fontSize: 13)),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 16, thickness: 0.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Net Margin:',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      Text(
                        '₹${performance.netProfit.toStringAsFixed(0)}',
                        style: TextStyle(
                            color: isProfitable
                                ? Colors.blueAccent
                                : Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
