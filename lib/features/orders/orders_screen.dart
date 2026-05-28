import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'order_provider.dart';
import '../../models/order.dart';
import '../crm/crm_provider.dart';
import '../../models/client.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  void _showAddOrderForm(
      BuildContext context, WidgetRef ref, List<Client> activeClients) {
    if (activeClients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please add a Customer in the CRM tab first!',
                style: TextStyle(color: Colors.white)),
            backgroundColor: AppTheme.statusDanger),
      );
      return;
    }

    Client? selectedClient = activeClients.first;
    final amountController = TextEditingController();
    String selectedWorkflow = 'Retail';
    String newClientType = 'retail'; // Only used if converting a lead

    final Map<String, List<String>> workflowTemplates = {
      'Retail': ['Received', 'Processing', 'Shipped', 'Delivered'],
      'Wholesale': [
        'Quote Accepted',
        'Procurement',
        'Production',
        'Shipped',
        'Invoiced',
        'Paid'
      ],
      'Custom B2B': [
        'Consultation',
        'Custom Build',
        'QA Testing',
        'Delivered',
        'Net-30 Paid'
      ]
    };

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            bool isConvertingLead = selectedClient?.relationshipStage == 'lead';

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 20,
                right: 20,
                top: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Create New Order',
                        style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),

                    // CRM CLIENT SELECTOR
                    DropdownButtonFormField<Client>(
                      dropdownColor: AppTheme.cardColor,
                      initialValue: selectedClient,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: _inputDecoration('Select Customer'),
                      items: activeClients.map((Client client) {
                        return DropdownMenuItem<Client>(
                          value: client,
                          child: Text(
                              '${client.name} ${client.businessName != null ? '(${client.businessName})' : ''} - [${client.relationshipStage == 'lead' ? 'Lead' : 'Client'}]'),
                        );
                      }).toList(),
                      onChanged: (newValue) =>
                          setModalState(() => selectedClient = newValue),
                    ),
                    const SizedBox(height: 16),

                    // LEAD CONVERSION TRIGGER (Rule #4)
                    if (isConvertingLead) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppTheme.accentBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.accentBlue)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.auto_awesome,
                                    color: AppTheme.accentBlue, size: 16),
                                SizedBox(width: 8),
                                Text('Lead Auto-Conversion',
                                    style: TextStyle(
                                        color: AppTheme.accentBlue,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text(
                                'This order will convert them to an Active Client. Select their new account type:',
                                style: TextStyle(
                                    color: AppTheme.textSecondary,
                                    fontSize: 12)),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: AppTheme.cardColor,
                              initialValue: newClientType,
                              style:
                                  const TextStyle(color: AppTheme.textPrimary),
                              decoration: _inputDecoration('New Client Type'),
                              items: const [
                                DropdownMenuItem(
                                    value: 'wholesale',
                                    child: Text('Wholesale')),
                                DropdownMenuItem(
                                    value: 'retail', child: Text('Retail')),
                                DropdownMenuItem(
                                    value: 'custom_b2b',
                                    child: Text('Custom B2B')),
                              ],
                              onChanged: (val) =>
                                  setModalState(() => newClientType = val!),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: _inputDecoration('Total Amount (₹)'),
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      dropdownColor: AppTheme.cardColor,
                      initialValue: selectedWorkflow,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: _inputDecoration('Order Workflow Pipeline'),
                      items: workflowTemplates.keys
                          .map((String value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (newValue) =>
                          setModalState(() => selectedWorkflow = newValue!),
                    ),
                    const SizedBox(height: 12),

                    Text(
                        'Timeline Preview: ${workflowTemplates[selectedWorkflow]!.join(" → ")}',
                        style: const TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 12,
                            fontStyle: FontStyle.italic)),

                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentAmber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (selectedClient != null &&
                              amountController.text.isNotEmpty) {
                            ref.read(orderProvider.notifier).addOrder(
                                  selectedClient!.id,
                                  selectedClient!.name ?? 'Unknown',
                                  double.tryParse(amountController.text) ?? 0.0,
                                  workflowTemplates[selectedWorkflow]!,
                                  newClientType:
                                      isConvertingLead ? newClientType : null,
                                );
                            // Refresh CRM to show updated math globally!
                            ref.read(crmProvider.notifier).loadClients();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Create Order & Update CRM',
                            style: TextStyle(
                                color: AppTheme.bgColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
      filled: true,
      fillColor: AppTheme.bgColor,
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.cardColor),
          borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.accentAmber),
          borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(orderProvider);
    final activeClients = ref.watch(
        crmProvider); // We watch the CRM provider to populate the dropdown!

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle, color: AppTheme.accentAmber),
            onPressed: () => _showAddOrderForm(context, ref, activeClients),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text('No active orders.',
                  style: TextStyle(color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderCard(order: order, ref: ref);
              },
            ),
    );
  }
}

// (The OrderCard widget remains exactly the same as you already had it!)
// ... Keep the top half of your orders_screen.dart file exactly the same (up to the build method) ...

class OrderCard extends StatelessWidget {
  final Order order;
  final WidgetRef ref;

  const OrderCard({super.key, required this.order, required this.ref});

  @override
  Widget build(BuildContext context) {
    final stages = order.stages ?? [];
    final currentStage = order.currentStageIndex;
    final isComplete = order.orderStatus == 'Completed';
    final isCancelled = order.orderStatus == 'Cancelled';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isCancelled
            ? const BorderSide(color: AppTheme.statusDanger, width: 1)
            : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.orderNumber ?? 'Unknown',
                    style: TextStyle(
                        color: isCancelled
                            ? AppTheme.textSecondary
                            : AppTheme.accentBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        decoration:
                            isCancelled ? TextDecoration.lineThrough : null)),
                Row(
                  children: [
                    if (order.isPaid)
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                            color: AppTheme.statusSuccess.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Text('PAID',
                            style: TextStyle(
                                color: AppTheme.statusSuccess,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                    Text('₹${order.totalAmount}',
                        style: TextStyle(
                            color: isCancelled
                                ? AppTheme.textSecondary
                                : AppTheme.textPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
                '${order.clientName} • ${order.date?.toLocal().toString().split(' ')[0]}',
                style: const TextStyle(
                    color: AppTheme.textSecondary, fontSize: 14)),

            const Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Divider(color: AppTheme.surfaceColor, thickness: 2)),

            // STATUS INDICATOR / TRACKER
            if (isCancelled)
              const Center(
                  child: Text('ORDER CANCELLED',
                      style: TextStyle(
                          color: AppTheme.statusDanger,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2)))
            else ...[
              const Text('Task Tracker',
                  style: TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(stages.length, (index) {
                    bool isCompletedStep = index < currentStage;
                    bool isActiveStep = index == currentStage;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: _buildStagePill(stages[index], isCompletedStep,
                          isActiveStep, isComplete),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),

              // ACTION BUTTONS
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: isComplete
                                ? AppTheme.statusSuccess
                                : AppTheme.accentAmber),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        foregroundColor: isComplete
                            ? AppTheme.statusSuccess
                            : AppTheme.accentAmber,
                      ),
                      onPressed: isComplete
                          ? null
                          : () async {
                              await ref
                                  .read(orderProvider.notifier)
                                  .advanceStage(order.id);
                              ref
                                  .read(crmProvider.notifier)
                                  .loadClients(); // Refresh CRM math UI
                            },
                      child:
                          Text(isComplete ? 'Order Complete' : 'Advance Stage'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (!order.isPaid)
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.statusSuccess,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: EdgeInsets.zero),
                        onPressed: () async {
                          await ref
                              .read(orderProvider.notifier)
                              .markOrderPaid(order.id);
                          ref
                              .read(crmProvider.notifier)
                              .loadClients(); // Refresh CRM math UI
                        },
                        child: const Text('Pay',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),

              // CANCEL BUTTON
              if (!isComplete && !order.isPaid)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      await ref
                          .read(orderProvider.notifier)
                          .cancelOrder(order.id);
                      ref
                          .read(crmProvider.notifier)
                          .loadClients(); // Refresh CRM math UI
                    },
                    child: const Text('Cancel Order',
                        style: TextStyle(
                            color: AppTheme.statusDanger, fontSize: 12)),
                  ),
                )
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStagePill(
      String label, bool isCompleted, bool isActive, bool isFullyComplete) {
    Color bgColor = AppTheme.surfaceColor;
    Color textColor = AppTheme.textSecondary;
    IconData? icon;

    if (isCompleted || (isFullyComplete && isActive)) {
      bgColor = AppTheme.statusSuccess.withOpacity(0.2);
      textColor = AppTheme.statusSuccess;
      icon = Icons.check_circle;
    } else if (isActive) {
      bgColor = AppTheme.accentAmber.withOpacity(0.2);
      textColor = AppTheme.accentAmber;
      icon = Icons.radio_button_checked;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: isActive && !isFullyComplete
            ? Border.all(color: AppTheme.accentAmber, width: 1)
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor),
            const SizedBox(width: 4)
          ],
          Text(label,
              style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
