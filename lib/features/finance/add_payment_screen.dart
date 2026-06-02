import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../crm/crm_provider.dart';
import '../orders/order_provider.dart';
import '../inventory/inventory_provider.dart';

class AddPaymentScreen extends ConsumerStatefulWidget {
  final int? prefilledClientId;
  final int? prefilledOrderId;
  final bool prefillPayAll;

  const AddPaymentScreen(
      {super.key,
      this.prefilledClientId,
      this.prefilledOrderId,
      this.prefillPayAll = false});

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
  final _amountController = TextEditingController();
  int? _selectedClientId;
  int? _selectedOrderId;
  String _paymentMethod = 'Bank Transfer';
  bool _isLoading = false;

  // --- THE FIX: State variable for the selected date ---
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedClientId = widget.prefilledClientId;
    if (widget.prefillPayAll) {
      _selectedOrderId = -1;
    } else {
      _selectedOrderId = widget.prefilledOrderId;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  // --- THE FIX: Date Picker Method ---
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.blueAccent,
              onPrimary: Colors.white,
              surface: AppTheme.surfaceDark,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: AppTheme.backgroundDark,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(activeClientsProvider);
    final clientOrdersAsync = _selectedClientId != null
        ? ref.watch(clientOrdersProvider(_selectedClientId!))
        : const AsyncValue.data([]);

    return Scaffold(
      appBar: AppBar(
          title: const Text('Record Payment'),
          backgroundColor: AppTheme.surfaceDark),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text('Client & Order Details',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            clientsAsync.when(
              loading: () => const CircularProgressIndicator(),
              error: (e, _) =>
                  Text('Error: $e', style: const TextStyle(color: Colors.red)),
              data: (clients) {
                if (clients.isEmpty)
                  return const Text('No active clients available.',
                      style: TextStyle(color: Colors.grey));

                final safeClientId =
                    clients.any((c) => c.id == _selectedClientId)
                        ? _selectedClientId
                        : null;

                return DropdownButtonFormField<int>(
                  value: safeClientId,
                  dropdownColor: AppTheme.surfaceDark,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      labelText: 'Select Client',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent))),
                  items: clients
                      .map((c) => DropdownMenuItem<int>(
                          value: c.id,
                          child: Text(c.businessName ?? c.name ?? 'Unknown')))
                      .toList(),
                  onChanged: widget.prefilledClientId != null
                      ? null
                      : (val) => setState(() {
                            _selectedClientId = val;
                            _selectedOrderId = null;
                          }),
                );
              },
            ),
            const SizedBox(height: 16),

            if (_selectedClientId != null)
              clientOrdersAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => const SizedBox(),
                data: (orders) {
                  final unpaidOrders =
                      orders.where((o) => o.status == 'Delivered').toList();
                  final safeOrderId = (_selectedOrderId == -1 ||
                          unpaidOrders.any((o) => o.id == _selectedOrderId))
                      ? _selectedOrderId
                      : null;

                  final List<DropdownMenuItem<int>> dropdownItems = [];
                  if (unpaidOrders.length > 1 || safeOrderId == -1) {
                    dropdownItems.add(const DropdownMenuItem<int>(
                        value: -1,
                        child: Text('Pay All Unpaid Orders (Bulk)',
                            style: TextStyle(
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold))));
                  }

                  dropdownItems.addAll(unpaidOrders.map((o) =>
                      DropdownMenuItem<int>(
                          value: o.id,
                          child: Text('Order #${o.id} - Pending Payment'))));

                  return DropdownButtonFormField<int>(
                    value: safeOrderId,
                    dropdownColor: AppTheme.surfaceDark,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: 'Link to Specific Order (Optional)',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent))),
                    items: dropdownItems.isEmpty ? null : dropdownItems,
                    onChanged: (widget.prefilledOrderId != null ||
                            widget.prefillPayAll)
                        ? null
                        : (val) => setState(() => _selectedOrderId = val),
                  );
                },
              ),

            if (_selectedOrderId == -1 && _selectedClientId != null) ...[
              const SizedBox(height: 16),
              _BulkOrderSummaryCard(clientId: _selectedClientId!),
            ] else if (_selectedOrderId != null) ...[
              const SizedBox(height: 16),
              _OrderSummaryCard(orderId: _selectedOrderId!),
            ],

            const SizedBox(height: 32),
            const Text('Payment Details',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // --- THE FIX: Display Date Picker Row ---
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        color: Colors.grey, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      'Date Received: ${_selectedDate.toString().split(' ')[0]}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    const Icon(Icons.edit, color: Colors.blueAccent, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Amount Received (₹)',
                  hintText: 'Enter exact amount',
                  hintStyle: TextStyle(color: Colors.white30),
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent))),
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _paymentMethod,
              dropdownColor: AppTheme.surfaceDark,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent))),
              items: ['Bank Transfer', 'Cash', 'UPI', 'Cheque']
                  .map(
                      (m) => DropdownMenuItem<String>(value: m, child: Text(m)))
                  .toList(),
              onChanged: (val) => setState(() => _paymentMethod = val!),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white),
              onPressed: _isLoading || _selectedClientId == null
                  ? null
                  : () async {
                      final amount = double.tryParse(_amountController.text);
                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Enter a valid amount.'),
                                backgroundColor: Colors.red));
                        return;
                      }

                      setState(() => _isLoading = true);
                      try {
                        // --- THE FIX: Pass _selectedDate to the service ---
                        if (_selectedOrderId == -1) {
                          await ref
                              .read(financeServiceProvider)
                              .recordBulkPayment(
                                  _selectedClientId!, amount, _paymentMethod,
                                  customDate: _selectedDate); // <-- Passed Here
                        } else {
                          await ref.read(financeServiceProvider).recordPayment(
                              _selectedClientId!, amount, _paymentMethod,
                              orderId: _selectedOrderId,
                              customDate: _selectedDate); // <-- Passed Here
                        }

                        ref.invalidate(
                            clientBalanceProvider(_selectedClientId!));
                        ref.invalidate(historyOrdersProvider);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Payment saved successfully!'),
                                  backgroundColor: Colors.green));
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    backgroundColor: AppTheme.surfaceDark,
                                    title: const Text('Overpayment Detected',
                                        style: TextStyle(
                                            color: Colors.orangeAccent)),
                                    content: Text(
                                        e
                                            .toString()
                                            .replaceAll('Exception: ', ''),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'))
                                    ],
                                  ));
                        }
                      } finally {
                        if (context.mounted) setState(() => _isLoading = false);
                      }
                    },
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Confirm Payment',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends ConsumerWidget {
  final int orderId;
  const _OrderSummaryCard({required this.orderId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(orderBalanceProvider(orderId));
    final itemsAsync = ref.watch(orderLineItemsProvider(orderId));
    final invAsync = ref.watch(inventoryItemsProvider);

    final orderAsync = ref.watch(singleOrderProvider(orderId));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppTheme.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Single Invoice Summary',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          itemsAsync.when(
            loading: () => const Center(
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2))),
            error: (e, _) =>
                Text('Error: $e', style: const TextStyle(color: Colors.red)),
            data: (items) {
              final inventory = invAsync.value ?? [];

              final order = orderAsync.value;
              final rawDeliveryCost = order?.deliveryCost ?? 0.0;
              final safeDeliveryCost =
                  rawDeliveryCost.isNaN ? 0.0 : rawDeliveryCost;

              return Column(
                children: [
                  ...items.map((item) {
                    final invItem = inventory
                        .where((i) => i.id == item.inventoryItemId)
                        .firstOrNull;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              '${item.quantity} ${item.unit ?? invItem?.unit ?? "x"}  ${invItem?.name ?? "Item"}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14)),
                          Text(
                              '₹${(item.quantity * item.pricePerUnit).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  if (safeDeliveryCost > 0) ...[
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Logistics / Delivery',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14)),
                        Text('₹${safeDeliveryCost.toStringAsFixed(2)}',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
          const Divider(color: Colors.grey, height: 24),
          balanceAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (balance) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pending Balance:',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('₹${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BulkOrderSummaryCard extends ConsumerWidget {
  final int clientId;
  const _BulkOrderSummaryCard({required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalBalanceAsync = ref.watch(clientBalanceProvider(clientId));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppTheme.backgroundDark,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.greenAccent.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Bulk Invoice Summary',
              style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text(
              'Payment will be distributed automatically to clear the oldest unpaid invoices first.',
              style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontStyle: FontStyle.italic)),
          const Divider(color: Colors.grey, height: 24),
          globalBalanceAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (balance) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Client Dues:',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  Text('₹${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
