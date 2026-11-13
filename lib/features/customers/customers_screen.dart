import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import 'customer_detail_screen.dart';
import 'customer_form_screen.dart';

enum _Filter { all, owe, suppliers }

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  _Filter _filter = _Filter.all;
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(t.navCustomers),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_alt_1),
            tooltip: t.customerNew,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerFormScreen())),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(116),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: SearchBar(
                hintText: t.search,
                leading: const Icon(Icons.search),
                onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    for (final (f, label) in [
                      (_Filter.all, t.customersAll),
                      (_Filter.owe, t.customersOwe),
                      (_Filter.suppliers, t.customersSuppliers),
                    ])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                            label: Text(label), selected: _filter == f, onSelected: (_) => setState(() => _filter = f)),
                      ),
                  ]),
            ),
          ]),
        ),
      ),
      body: AsyncBody(
        ref.watch(partiesProvider),
        builder: (rows) {
          final shown = rows.where((r) {
            final p = r.party;
            final isSupplier = p.role == PartyRole.supplier;
            final ok = switch (_filter) {
              _Filter.all => !isSupplier,
              _Filter.owe => r.balancePaise > 0,
              _Filter.suppliers => p.role != PartyRole.customer,
            };
            if (!ok) return false;
            if (_query.isEmpty) return true;
            return '${p.name} ${p.businessName ?? ''} ${p.phone ?? ''}'.toLowerCase().contains(_query);
          }).toList();
          if (_filter == _Filter.owe) {
            shown.sort((a, b) =>
                b.daysLate != a.daysLate ? b.daysLate.compareTo(a.daysLate) : b.balancePaise.compareTo(a.balancePaise));
          }
          if (shown.isEmpty) return EmptyState(icon: Icons.people_outline, text: t.customersEmpty);
          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 120),
            itemCount: shown.length,
            itemBuilder: (_, i) {
              final r = shown[i];
              return ListTile(
                leading: CircleAvatar(child: Text(r.party.name.isEmpty ? '?' : r.party.name[0].toUpperCase())),
                title: Text(r.party.name, style: const TextStyle(fontSize: 18)),
                subtitle: _Sub(r.party.businessName ?? r.party.phone ?? t.role(r.party.role),
                    r.party.role == PartyRole.supplier ? null : BalancePill(r.balancePaise, daysLate: r.daysLate)),
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CustomerDetailScreen(partyId: r.party.id))),
              );
            },
          );
        },
      ),
    );
  }
}

/// Second line of a person row: who they are, then their balance badge.
class _Sub extends StatelessWidget {
  const _Sub(this.text, this.badge);
  final String text;
  final Widget? badge;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(text),
        if (badge != null) Padding(padding: const EdgeInsets.only(top: 6), child: badge),
      ]);
}
