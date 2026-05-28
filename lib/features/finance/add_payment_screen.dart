import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import '../crm/crm_provider.dart';

class AddPaymentScreen extends ConsumerStatefulWidget {
  const AddPaymentScreen({super.key});

  @override
  ConsumerState<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends ConsumerState<AddPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();

  int? _selectedClientId;
  String _selectedMethod = 'Bank Transfer';
  bool _isLoading = false;

  Future<void> _submitPayment() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedClientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a client.'),
          backgroundColor: Colors.red));
      return;
    }

    setState(() => _isLoading = true);

    try {
      final amount = double.parse(_amountController.text.trim());

      // Hand the data to the Service Layer
      final financeService = ref.read(financeServiceProvider);
      await financeService.recordPayment(
          _selectedClientId!, amount, _selectedMethod);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Payment recorded successfully!'),
            backgroundColor: Colors.green));
        Navigator.pop(context); // Go back to the ledger
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(activeClientsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Record Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- CLIENT SELECTION ---
              clientsAsync.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => Text('Error: $e'),
                data: (clients) {
                  return DropdownButtonFormField<int>(
                    value: _selectedClientId,
                    dropdownColor: AppTheme.surfaceDark,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Select Client',
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent)),
                    ),
                    items: clients
                        .map((c) => DropdownMenuItem(
                            value: c.id,
                            child: Text(c.businessName ?? c.name ?? 'Unknown')))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedClientId = val),
                  );
                },
              ),
              const SizedBox(height: 12),

              // --- SMART BALANCE DISPLAY ---
              // If a client is selected, dynamically show what they owe!
              if (_selectedClientId != null)
                Consumer(
                  builder: (context, ref, child) {
                    final balanceAsync =
                        ref.watch(clientBalanceProvider(_selectedClientId!));
                    return balanceAsync.when(
                      loading: () => const Text('Calculating balance...'),
                      error: (_, __) => const SizedBox(),
                      data: (balance) {
                        return Text(
                          balance > 0
                              ? 'Client currently owes: ₹${balance.toStringAsFixed(2)}'
                              : 'Client is fully settled.',
                          style: TextStyle(
                              color: balance > 0
                                  ? Colors.redAccent
                                  : Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    );
                  },
                ),
              const SizedBox(height: 24),

              // --- PAYMENT AMOUNT ---
              TextFormField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Amount Received (₹)',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  prefixIcon: Icon(Icons.currency_rupee, color: Colors.grey),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty)
                    return 'Please enter an amount';
                  if (double.tryParse(val) == null)
                    return 'Please enter a valid number';
                  if (double.parse(val) <= 0)
                    return 'Amount must be greater than zero';
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // --- PAYMENT METHOD ---
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                dropdownColor: AppTheme.surfaceDark,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Payment Method',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                ),
                items: ['Bank Transfer', 'UPI', 'Cash', 'Credit Card', 'Cheque']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedMethod = val!),
              ),
              const SizedBox(height: 32),

              // --- SUBMIT BUTTON ---
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isLoading ? null : _submitPayment,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Record Payment',
                        style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
