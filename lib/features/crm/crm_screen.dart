import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/providers/core_providers.dart';
import 'crm_provider.dart';
import 'add_client_screen.dart'; // <-- 1. Import for the new form

class CRMScreen extends ConsumerWidget {
  const CRMScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(activeClientsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CRM & Leads'),
        backgroundColor: AppTheme.surfaceDark,
      ),
      body: clientsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (clients) {
          if (clients.isEmpty) {
            return const Center(
                child: Text('No active clients or leads.',
                    style: TextStyle(color: Colors.grey)));
          }

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppTheme.surfaceDark,
                child: ListTile(
                  title: Text(client.businessName ?? client.name ?? 'Unnamed',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  subtitle: Text(
                      '${client.type} • ${client.location ?? "No location"}',
                      style: const TextStyle(color: Colors.grey)),
                  trailing: _ClientBalanceBadge(clientId: client.id),
                ),
              );
            },
          );
        },
      ),
      // <-- 2. THE MISSING BUTTON IS BACK!
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          // Navigate to our new form screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddClientScreen()),
          );
        },
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}

class _ClientBalanceBadge extends ConsumerWidget {
  final int clientId;
  const _ClientBalanceBadge({required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(clientBalanceProvider(clientId));

    return balanceAsync.when(
      loading: () => const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(strokeWidth: 2)),
      error: (_, __) => const Icon(Icons.error, color: Colors.red),
      data: (balance) {
        if (balance <= 0) {
          return const Text('Settled',
              style:
                  TextStyle(color: Colors.green, fontWeight: FontWeight.bold));
        }

        // THE FIX: Removed the GestureDetector hack. It is now a clean, unclickable badge.
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.redAccent.withOpacity(0.5)),
          ),
          child: Text('Owes ₹${balance.toStringAsFixed(0)}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12)),
        );
      },
    );
  }
}
