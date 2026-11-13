// Pick a customer (or supplier) from a searchable list, or add a new one.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/format.dart';
import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../customers/customer_form_screen.dart';

Future<Party?> pickParty(BuildContext context, {bool suppliers = false}) => showModalBottomSheet<Party>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (_) => _PartyPicker(suppliers: suppliers),
    );

class _PartyPicker extends ConsumerStatefulWidget {
  const _PartyPicker({required this.suppliers});
  final bool suppliers;

  @override
  ConsumerState<_PartyPicker> createState() => _PartyPickerState();
}

class _PartyPickerState extends ConsumerState<_PartyPicker> {
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: SearchBar(
            autoFocus: true,
            hintText: t.search,
            leading: const Icon(Icons.search),
            onChanged: (v) => setState(() => _q = v.trim().toLowerCase()),
          ),
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person_add)),
          title: Text(widget.suppliers ? '+ ${t.roleSupplier}' : '+ ${t.customerNew}'),
          onTap: () async {
            final id = await Navigator.push<String>(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    CustomerFormScreen(initialRole: widget.suppliers ? PartyRole.supplier : PartyRole.customer),
              ),
            );
            if (id == null || !context.mounted) return;
            final party = await ref.read(catalogProvider).party(id);
            if (context.mounted) Navigator.pop(context, party);
          },
        ),
        const Divider(height: 1),
        Expanded(
          child: AsyncBody(ref.watch(partiesProvider), builder: (rows) {
            final shown = rows.where((r) {
              final role = r.party.role;
              final fits = widget.suppliers ? role != PartyRole.customer : role != PartyRole.supplier;
              return fits &&
                  (_q.isEmpty ||
                      '${r.party.name} ${r.party.businessName ?? ''} ${r.party.phone ?? ''}'
                          .toLowerCase()
                          .contains(_q));
            }).toList();
            return ListView.builder(
              itemCount: shown.length,
              itemBuilder: (_, i) => ListTile(
                leading: CircleAvatar(child: Text(shown[i].party.name.isEmpty ? '?' : shown[i].party.name[0])),
                title: Text(shown[i].party.name, style: const TextStyle(fontSize: 18)),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(shown[i].party.businessName ?? shown[i].party.phone ?? ''),
                  if (!widget.suppliers)
                    Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: BalancePill(shown[i].balancePaise, daysLate: shown[i].daysLate)),
                ]),
                onTap: () => Navigator.pop(context, shown[i].party),
              ),
            );
          }),
        ),
      ]),
    );
  }
}

/// Looks like a text field; tap to choose.
class PartyField extends StatelessWidget {
  const PartyField(
      {super.key,
      required this.party,
      required this.onPicked,
      this.enabled = true,
      this.suppliers = false,
      this.label});
  final Party? party;
  final ValueChanged<Party> onPicked;
  final bool enabled;
  final bool suppliers;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return InkWell(
      onTap: !enabled
          ? null
          : () async {
              final p = await pickParty(context, suppliers: suppliers);
              if (p != null) onPicked(p);
            },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label ?? t.orderCustomer,
          prefixIcon: const Icon(Icons.person),
          suffixIcon: enabled ? const Icon(Icons.arrow_drop_down) : null,
        ),
        child: Text(party?.name ?? t.orderPickCustomer, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
