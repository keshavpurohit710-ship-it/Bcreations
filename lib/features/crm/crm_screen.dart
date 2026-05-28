import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import 'crm_provider.dart';
import '../../models/client.dart';
import '../orders/order_provider.dart';

class CRMScreen extends ConsumerStatefulWidget {
  const CRMScreen({super.key});

  @override
  ConsumerState<CRMScreen> createState() => _CRMScreenState();
}

class _CRMScreenState extends ConsumerState<CRMScreen> {
  bool _isTableView = false;
  final TextEditingController _searchController = TextEditingController();

  String? _filterStage;
  String? _filterType;
  String? _filterStatus = 'Active';
  bool _filterOutstandingOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatUIText(String? raw) {
    if (raw == null || raw.isEmpty) return 'N/A';
    switch (raw) {
      case 'wholesale':
        return 'Wholesale';
      case 'retail':
        return 'Retail';
      case 'custom_b2b':
        return 'Custom B2B';
      case 'lead':
        return 'Lead';
      case 'client':
        return 'Client';
      case 'active_client':
        return 'Active Client';
      default:
        return raw;
    }
  }

  Color _getStageColor(String? stage) {
    if (stage == 'client' || stage == 'active_client')
      return AppTheme.statusSuccess;
    return AppTheme.accentBlue;
  }

  Color _getStatusColor(String? status) {
    if (status == 'Active') return AppTheme.statusSuccess;
    if (status == 'Inactive') return AppTheme.statusWarning;
    return AppTheme.textSecondary;
  }

  Color _getHealthColor(String health) {
    if (health == 'Healthy') return AppTheme.statusSuccess;
    if (health == 'Attention Needed') return AppTheme.accentAmber;
    if (health == 'High Risk') return AppTheme.statusDanger;
    return AppTheme.textSecondary; // Inactive or Lead
  }

  Widget _buildPill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8)),
      child: Text(text,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  List<Client> _getFilteredClients(List<Client> allClients) {
    return allClients.where((client) {
      final query = _searchController.text.toLowerCase().trim();
      if (query.isNotEmpty) {
        final nameMatch = client.name?.toLowerCase().contains(query) ?? false;
        final phoneMatch = client.phone?.contains(query) ?? false;
        final businessMatch =
            client.businessName?.toLowerCase().contains(query) ?? false;
        final locationMatch =
            client.location?.toLowerCase().contains(query) ?? false;
        if (!nameMatch && !phoneMatch && !businessMatch && !locationMatch)
          return false;
      }

      if (_filterStage != null && client.relationshipStage != _filterStage)
        return false;
      if (_filterType != null && client.clientType != _filterType) return false;
      if (_filterStatus != null && client.status != _filterStatus) return false;
      if (_filterOutstandingOnly && client.outstandingAmount <= 0) return false;

      return true;
    }).toList();
  }

  void _showFilterDrawer() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDrawerState) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Advanced Filters',
                      style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.surfaceColor,
                    value: _filterStage,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Relationship Stage',
                        labelStyle: TextStyle(color: AppTheme.textSecondary)),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All Stages')),
                      DropdownMenuItem(value: 'lead', child: Text('Lead')),
                      DropdownMenuItem(
                          value: 'active_client', child: Text('Client')),
                    ],
                    onChanged: (val) =>
                        setDrawerState(() => _filterStage = val),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.surfaceColor,
                    value: _filterType,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Client Type',
                        labelStyle: TextStyle(color: AppTheme.textSecondary)),
                    items: const [
                      DropdownMenuItem(value: null, child: Text('All Types')),
                      DropdownMenuItem(
                          value: 'wholesale', child: Text('Wholesale')),
                      DropdownMenuItem(value: 'retail', child: Text('Retail')),
                      DropdownMenuItem(
                          value: 'custom_b2b', child: Text('Custom B2B')),
                    ],
                    onChanged: (val) => setDrawerState(() => _filterType = val),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    dropdownColor: AppTheme.surfaceColor,
                    value: _filterStatus,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    decoration: const InputDecoration(
                        labelText: 'Lifecycle Status',
                        labelStyle: TextStyle(color: AppTheme.textSecondary)),
                    items: const [
                      DropdownMenuItem(
                          value: null,
                          child: Text('All statuses (incl. Archived)')),
                      DropdownMenuItem(
                          value: 'Active', child: Text('Active Only')),
                      DropdownMenuItem(
                          value: 'Inactive', child: Text('Inactive Only')),
                      DropdownMenuItem(
                          value: 'Archived', child: Text('Archived Only')),
                    ],
                    onChanged: (val) =>
                        setDrawerState(() => _filterStatus = val),
                  ),
                  CheckboxListTile(
                    title: const Text('Outstanding Balance > 0',
                        style: TextStyle(
                            color: AppTheme.textPrimary, fontSize: 14)),
                    value: _filterOutstandingOnly,
                    activeColor: AppTheme.accentAmber,
                    checkColor: AppTheme.bgColor,
                    onChanged: (val) =>
                        setDrawerState(() => _filterOutstandingOnly = val!),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentAmber),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text('Apply Filter Settings',
                          style: TextStyle(
                              color: AppTheme.bgColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddClientForm() {
    final nameCtrl = TextEditingController();
    final businessCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final locationCtrl = TextEditingController();

    String stage = 'lead';
    String type = 'wholesale';
    String source = 'Referral';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setFormState) {
            bool isName = nameCtrl.text.trim().isNotEmpty;
            bool isPhone = phoneCtrl.text.trim().isNotEmpty;
            bool isBiz = businessCtrl.text.trim().isNotEmpty;
            bool isValid = isName && (isPhone || isBiz);

            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 20,
                  right: 20,
                  top: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('New CRM Entry',
                        style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                            child: ChoiceChip(
                                label: const Text('Lead'),
                                selected: stage == 'lead',
                                selectedColor:
                                    AppTheme.accentBlue.withOpacity(0.2),
                                onSelected: (_) =>
                                    setFormState(() => stage = 'lead'))),
                        const SizedBox(width: 8),
                        Expanded(
                            child: ChoiceChip(
                                label: const Text('Client'),
                                selected: stage == 'active_client',
                                selectedColor:
                                    AppTheme.statusSuccess.withOpacity(0.2),
                                onSelected: (_) => setFormState(
                                    () => stage = 'active_client'))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(nameCtrl, 'Contact Name *', setFormState),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                            child: _buildTextField(
                                phoneCtrl, 'Phone', setFormState,
                                isPhone: true)),
                        const SizedBox(width: 8),
                        Expanded(
                            child: _buildTextField(
                                businessCtrl, 'Business Name', setFormState)),
                      ],
                    ),
                    if (!isValid)
                      const Padding(
                          padding: EdgeInsets.only(top: 4.0),
                          child: Text(
                              'Must provide Name AND (Phone or Business Name)',
                              style: TextStyle(
                                  color: AppTheme.statusDanger, fontSize: 12))),
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child:
                            Divider(color: AppTheme.cardColor, thickness: 1)),
                    _buildTextField(emailCtrl, 'Email Address', setFormState),
                    const SizedBox(height: 8),
                    _buildTextField(
                        locationCtrl, 'Location (City)', setFormState),
                    const SizedBox(height: 8),
                    if (stage == 'lead')
                      DropdownButtonFormField<String>(
                        value: source,
                        dropdownColor: AppTheme.surfaceColor,
                        style: const TextStyle(color: AppTheme.textPrimary),
                        decoration: _inputDecoration('Lead Source'),
                        items: [
                          'Referral',
                          'Walk-in',
                          'WhatsApp',
                          'Website',
                          'Cold Outreach',
                          'Existing Client Referral',
                          'Other'
                        ]
                            .map((s) =>
                                DropdownMenuItem(value: s, child: Text(s)))
                            .toList(),
                        onChanged: (v) => setFormState(() => source = v!),
                      )
                    else
                      DropdownButtonFormField<String>(
                        value: type,
                        dropdownColor: AppTheme.surfaceColor,
                        style: const TextStyle(color: AppTheme.textPrimary),
                        decoration: _inputDecoration('Client Type'),
                        items: ['wholesale', 'retail', 'custom_b2b']
                            .map((s) => DropdownMenuItem(
                                value: s, child: Text(_formatUIText(s))))
                            .toList(),
                        onChanged: (v) => setFormState(() => type = v!),
                      ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: isValid
                                ? AppTheme.accentAmber
                                : AppTheme.cardColor),
                        onPressed: isValid
                            ? () async {
                                final duplicate = await ref
                                    .read(crmProvider.notifier)
                                    .checkDuplicate(
                                        phone: phoneCtrl.text,
                                        email: emailCtrl.text,
                                        name: nameCtrl.text,
                                        businessName: businessCtrl.text);
                                if (duplicate != null) {
                                  if (!mounted) return;
                                  _showDuplicateWarning(context, duplicate,
                                      onProceed: () => _executeSave(
                                          ref,
                                          nameCtrl,
                                          phoneCtrl,
                                          businessCtrl,
                                          emailCtrl,
                                          locationCtrl,
                                          stage,
                                          type,
                                          source));
                                } else {
                                  _executeSave(
                                      ref,
                                      nameCtrl,
                                      phoneCtrl,
                                      businessCtrl,
                                      emailCtrl,
                                      locationCtrl,
                                      stage,
                                      type,
                                      source);
                                }
                              }
                            : null,
                        child: const Text('Save Entry',
                            style: TextStyle(
                                color: AppTheme.bgColor,
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

  void _executeSave(
      WidgetRef ref,
      TextEditingController name,
      TextEditingController phone,
      TextEditingController business,
      TextEditingController email,
      TextEditingController location,
      String stage,
      String type,
      String source) {
    ref.read(crmProvider.notifier).addClient(
          name: name.text,
          phone: phone.text,
          businessName: business.text,
          email: email.text,
          location: location.text,
          relationshipStage: stage,
          clientType: stage == 'active_client' ? type : null,
          leadSource: stage == 'lead' ? source : null,
        );
    Navigator.pop(context);
  }

  void _showDuplicateWarning(BuildContext context, Client duplicate,
      {required VoidCallback onProceed}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: const Text('Duplicate Detected',
            style: TextStyle(color: AppTheme.statusDanger)),
        content: Text(
            'A record for "${duplicate.name}" already exists.\n\nPhone: ${duplicate.phone ?? 'N/A'}\nBusiness: ${duplicate.businessName ?? 'N/A'}\nStage: ${_formatUIText(duplicate.relationshipStage)}',
            style: const TextStyle(color: AppTheme.textPrimary)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.statusDanger),
            onPressed: () {
              Navigator.pop(context);
              onProceed();
            },
            child: const Text('Create Anyway',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, StateSetter setFormState,
      {bool isPhone = false}) {
    return TextField(
      controller: controller,
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      style: const TextStyle(color: AppTheme.textPrimary),
      onChanged: (_) => setFormState(() {}),
      decoration: _inputDecoration(label),
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

  // ==========================================
  // NEW: PROACTIVE INTELLIGENCE ENGINE
  // ==========================================
  List<Widget> _generateSmartSuggestions(Client client) {
    List<Widget> suggestions = [];
    final now = DateTime.now();

    // Rule 2: Pending Payment Exists
    if (client.outstandingAmount > 0) {
      suggestions.add(_smartCard(
        icon: Icons.money_off,
        color: AppTheme.statusDanger,
        title: 'Payment Pending',
        message:
            '₹${client.outstandingAmount} is outstanding. Send a polite reminder.',
        actionLabel: 'Remind',
        onAction: () => _executeQuickAction('WhatsApp', client),
      ));
    }

    // Rule 1: Dormant Account (Last order > 30 days ago)
    if (client.lastOrderDate != null) {
      final daysSince = now.difference(client.lastOrderDate!).inDays;
      if (daysSince > 30) {
        suggestions.add(_smartCard(
          icon: Icons.access_time,
          color: AppTheme.accentAmber,
          title: 'Dormant Account',
          message: 'Last order was $daysSince days ago. Suggest checking in.',
          actionLabel: 'Follow-up',
          onAction: () => _showQuickLogDialog('Add Follow-up', client),
        ));
      }
    }

    // Rule 3: Large Order Completed Recently (> 15k within last 14 days)
    if (client.lastOrderAmount >= 15000 && client.lastOrderDate != null) {
      final daysSince = now.difference(client.lastOrderDate!).inDays;
      if (daysSince <= 14) {
        suggestions.add(_smartCard(
          icon: Icons.star,
          color: AppTheme.statusSuccess,
          title: 'High-Value Client',
          message:
              'Recently completed a large order. Nurture the relationship.',
          actionLabel: 'Add Note',
          onAction: () => _showQuickLogDialog('Add Note', client),
        ));
      }
    }

    return suggestions;
  }

  Widget _smartCard(
      {required IconData icon,
      required Color color,
      required String title,
      required String message,
      required String actionLabel,
      required VoidCallback onAction}) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 6),
              Text(title,
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Text(message,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onAction,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
                child: Text(actionLabel,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // ENTERPRISE PROFILE MODAL (EDITABLE)
  // ==========================================
  void _showClientProfile(Client client) {
    final nameCtrl = TextEditingController(text: client.name);
    final businessCtrl = TextEditingController(text: client.businessName);
    final phoneCtrl = TextEditingController(text: client.phone);
    final emailCtrl = TextEditingController(text: client.email);
    final locationCtrl = TextEditingController(text: client.location);
    final notesCtrl = TextEditingController(text: client.notes);
    final limitCtrl =
        TextEditingController(text: client.creditLimit?.toString() ?? '');

    String currentStatus = client.status ?? 'Active';
    String? currentTerms = client.paymentTerms;
    String currentSource = client.leadSource ?? 'Referral';
    String currentType = client.clientType ?? 'wholesale';

    final allOrders = ref.read(orderProvider);
    final clientOrders =
        allOrders.where((o) => o.clientId == client.id).toList();

    final now = DateTime.now();
    final delayedOrdersCount = clientOrders
        .where((o) =>
            o.orderStatus == 'Active' &&
            o.expectedCompletionDate != null &&
            o.expectedCompletionDate!.isBefore(now))
        .length;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppTheme.bgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setProfileState) {
            return DraggableScrollableSheet(
              initialChildSize: 0.9,
              minChildSize: 0.6,
              maxChildSize: 0.95,
              expand: false,
              builder: (context, scrollController) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      const SizedBox(height: 12),
                      Center(
                          child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                  color: AppTheme.cardColor,
                                  borderRadius: BorderRadius.circular(2)))),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                                client.businessName?.isNotEmpty == true
                                    ? '${client.businessName} (${client.name})'
                                    : (client.name ?? 'Unknown'),
                                style: const TextStyle(
                                    color: AppTheme.textPrimary,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ),
                          _buildPill(_formatUIText(client.relationshipStage),
                              _getStageColor(client.relationshipStage)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // PROACTIVE INTELLIGENCE CAROUSEL
                      ...(() {
                        final suggestions = _generateSmartSuggestions(client);
                        if (suggestions.isEmpty)
                          return [const SizedBox.shrink()];
                        return [
                          _profileHeading('✨ AI Proactive Intelligence'),
                          SizedBox(
                            height: 110,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(children: suggestions),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ];
                      })(),

                      // IDENTITY
                      _profileHeading('Section 1 — Identity (Editable)'),
                      _buildProfileEditField('Name', nameCtrl),
                      _buildProfileEditField('Business Name', businessCtrl),
                      _buildProfileEditField('Phone', phoneCtrl),
                      _buildProfileEditField('Email', emailCtrl),
                      _buildProfileEditField('Location', locationCtrl),

                      // CRM DETAILS
                      _profileHeading('Section 2 — CRM Lifecycle'),
                      Row(
                        children: [
                          const SizedBox(
                              width: 120,
                              child: Text('Status',
                                  style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 13))),
                          Expanded(
                            child: DropdownButton<String>(
                              dropdownColor: AppTheme.surfaceColor,
                              value: currentStatus,
                              style:
                                  const TextStyle(color: AppTheme.textPrimary),
                              items: ['Active', 'Inactive', 'Archived']
                                  .map((val) => DropdownMenuItem(
                                      value: val, child: Text(val)))
                                  .toList(),
                              onChanged: (val) =>
                                  setProfileState(() => currentStatus = val!),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(
                                  client.isLead ? 'Lead Source' : 'Client Type',
                                  style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 13))),
                          Expanded(
                            child: DropdownButton<String>(
                              dropdownColor: AppTheme.surfaceColor,
                              value:
                                  client.isLead ? currentSource : currentType,
                              style:
                                  const TextStyle(color: AppTheme.textPrimary),
                              items: client.isLead
                                  ? [
                                      'Referral',
                                      'Walk-in',
                                      'WhatsApp',
                                      'Website',
                                      'Cold Outreach',
                                      'Existing Client Referral',
                                      'Other'
                                    ]
                                      .map((val) => DropdownMenuItem(
                                          value: val, child: Text(val)))
                                      .toList()
                                  : ['wholesale', 'retail', 'custom_b2b']
                                      .map((val) => DropdownMenuItem(
                                          value: val,
                                          child: Text(_formatUIText(val))))
                                      .toList(),
                              onChanged: (val) => setProfileState(() {
                                if (client.isLead)
                                  currentSource = val!;
                                else
                                  currentType = val!;
                              }),
                            ),
                          ),
                        ],
                      ),

                      _profileFieldRow(
                          'Last Contact',
                          client.lastContactDate?.toString().split(' ')[0] ??
                              'Never'),

                      InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate:
                                client.nextFollowUpDate ?? DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 365)),
                            lastDate: DateTime.now()
                                .add(const Duration(days: 365 * 5)),
                          );
                          if (picked != null) {
                            setProfileState(
                                () => client.nextFollowUpDate = picked);
                          }
                        },
                        child: _profileFieldRow(
                            'Next Follow-up',
                            client.nextFollowUpDate?.toString().split(' ')[0] ??
                                'Tap to schedule 📅',
                            isActionable: true),
                      ),

                      const SizedBox(height: 8),
                      TextField(
                        controller: notesCtrl,
                        style: const TextStyle(
                            color: AppTheme.textPrimary, fontSize: 14),
                        maxLines: 2,
                        decoration: _profileInputDecoration('General Notes'),
                      ),

                      // OPERATIONAL PIPELINE
                      _profileHeading('Section 3 — Operational Pipeline'),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: delayedOrdersCount > 0
                                ? AppTheme.statusDanger.withOpacity(0.1)
                                : AppTheme.surfaceColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: delayedOrdersCount > 0
                                    ? AppTheme.statusDanger
                                    : AppTheme.cardColor)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Current Active Orders:',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14)),
                                Text('${client.openOrders}',
                                    style: const TextStyle(
                                        color: AppTheme.textPrimary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Delayed Orders:',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14)),
                                Text('$delayedOrdersCount',
                                    style: TextStyle(
                                        color: delayedOrdersCount > 0
                                            ? AppTheme.statusDanger
                                            : AppTheme.statusSuccess,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(
                                    color: AppTheme.cardColor, height: 1)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Last Completed:',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 14)),
                                Text(
                                    client.lastCompletedOrderDate != null
                                        ? '${DateTime.now().difference(client.lastCompletedOrderDate!).inDays} days ago'
                                        : 'No completed orders',
                                    style: const TextStyle(
                                        color: AppTheme.textPrimary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          Expanded(
                              child: _metricBox(
                                  'Total Lifetime', '${client.totalOrders}')),
                          const SizedBox(width: 6),
                          Expanded(
                              child: _metricBox(
                                  'Revenue', '₹${client.totalRevenue}')),
                          const SizedBox(width: 6),
                          Expanded(
                              child: _metricBox('Avg Value',
                                  '₹${client.averageOrderValue.toStringAsFixed(0)}')),
                        ],
                      ),

                      // FINANCE
                      // THE NEW FINANCE HUB
                      if (!client.isLead) ...[
                        _profileHeading('Section 4 — Operational Finance'),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: AppTheme.surfaceColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total Outstanding',
                                      style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13)),
                                  Text('₹${client.outstandingAmount}',
                                      style: TextStyle(
                                          color: client.outstandingAmount > 0
                                              ? AppTheme.accentAmber
                                              : AppTheme.statusSuccess,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Overdue Amount',
                                      style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13)),
                                  Text('₹${client.overdueAmount}',
                                      style: TextStyle(
                                          color: client.overdueAmount > 0
                                              ? AppTheme.statusDanger
                                              : AppTheme.textPrimary,
                                          fontSize: 14,
                                          fontWeight: client.overdueAmount > 0
                                              ? FontWeight.bold
                                              : FontWeight.normal)),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Divider(
                                      color: AppTheme.cardColor, height: 1)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Last Payment Date',
                                      style: TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 13)),
                                  Text(
                                      client.lastPaymentDate
                                              ?.toString()
                                              .split(' ')[0] ??
                                          'No payments yet',
                                      style: const TextStyle(
                                          color: AppTheme.textPrimary,
                                          fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // EDITABLE CREDIT LIMIT & TERMS
                        Row(
                          children: [
                            const SizedBox(
                                width: 120,
                                child: Text('Payment Terms',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 13))),
                            Expanded(
                              child: DropdownButton<String>(
                                dropdownColor: AppTheme.surfaceColor,
                                value: currentTerms,
                                hint: const Text('Select Terms',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary)),
                                style: const TextStyle(
                                    color: AppTheme.textPrimary),
                                items: [
                                  'Immediate Payment',
                                  '15 Days',
                                  '30 Days',
                                  'Net-60'
                                ]
                                    .map((val) => DropdownMenuItem(
                                        value: val, child: Text(val)))
                                    .toList(),
                                onChanged: (val) =>
                                    setProfileState(() => currentTerms = val),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _buildProfileEditField('Credit Limit (₹)', limitCtrl),

                        if (client.creditLimit != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Row(
                              children: [
                                const SizedBox(width: 120),
                                Expanded(
                                  child: Text(
                                      'Remaining Credit: ₹${client.remainingCredit}',
                                      style: TextStyle(
                                          color: client.remainingCredit! < 0
                                              ? AppTheme.statusDanger
                                              : AppTheme.statusSuccess,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                      ],
                      // TIMELINE UI
                      _profileHeading('Section 5 — Activity Feed'),
                      if (client.interactionHistory.isEmpty)
                        const Text('No activity logs found.',
                            style: TextStyle(
                                color: AppTheme.textSecondary, fontSize: 13))
                      else
                        ...List.generate(client.interactionHistory.length,
                            (index) {
                          final log = client.interactionHistory.reversed
                              .toList()[index];
                          final isLast =
                              index == client.interactionHistory.length - 1;

                          Color typeColor = AppTheme.textSecondary;
                          IconData typeIcon = Icons.circle;

                          if (log.interactionType == 'Order Created') {
                            typeColor = AppTheme.statusSuccess;
                            typeIcon = Icons.add_shopping_cart;
                          } else if (log.interactionType == 'Payment') {
                            typeColor = AppTheme.statusSuccess;
                            typeIcon = Icons.attach_money;
                          } else if (log.interactionType == 'Order Cancelled') {
                            typeColor = AppTheme.statusDanger;
                            typeIcon = Icons.cancel;
                          } else if (log.interactionType == 'Follow-up') {
                            typeColor = AppTheme.accentAmber;
                            typeIcon = Icons.calendar_today;
                          } else if (log.interactionType == 'WhatsApp') {
                            typeColor = Colors.green;
                            typeIcon = Icons.chat;
                          } else if (log.interactionType == 'Call') {
                            typeColor = AppTheme.accentBlue;
                            typeIcon = Icons.phone;
                          } else if (log.interactionType == 'System') {
                            typeColor = Colors.grey;
                            typeIcon = Icons.settings;
                          }

                          return IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: typeColor.withOpacity(0.2),
                                          shape: BoxShape.circle),
                                      child: Icon(typeIcon,
                                          size: 12, color: typeColor),
                                    ),
                                    if (!isLast)
                                      Expanded(
                                          child: Container(
                                              width: 2,
                                              color: AppTheme.cardColor)),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${log.timestamp?.toLocal().toString().substring(0, 16)}',
                                            style: const TextStyle(
                                                color: AppTheme.textSecondary,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text(log.description ?? '',
                                            style: const TextStyle(
                                                color: AppTheme.textPrimary,
                                                fontSize: 13)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),

                      const SizedBox(height: 24),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.statusSuccess),
                          onPressed: () {
                            ref.read(crmProvider.notifier).updateClientDetails(
                                  client.id,
                                  name: nameCtrl.text,
                                  businessName: businessCtrl.text,
                                  phone: phoneCtrl.text,
                                  email: emailCtrl.text,
                                  location: locationCtrl.text,
                                  notes: notesCtrl.text,
                                  status: currentStatus,
                                  leadSource:
                                      client.isLead ? currentSource : null,
                                  clientType:
                                      !client.isLead ? currentType : null,
                                  paymentTerms:
                                      !client.isLead ? currentTerms : null,
                                  creditLimit: !client.isLead
                                      ? double.tryParse(limitCtrl.text)
                                      : null,
                                  nextFollowUpDate: client.nextFollowUpDate,
                                );
                            Navigator.pop(context);
                          },
                          child: const Text('Save Profile Updates',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildProfileEditField(
      String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 13))),
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.cardColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppTheme.accentAmber)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text,
              style: const TextStyle(
                  color: AppTheme.accentBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const Divider(color: AppTheme.cardColor, thickness: 1),
        ],
      ),
    );
  }

  Widget _profileFieldRow(String label, String? val,
      {bool isAlert = false, bool isActionable = false}) {
    Color textColor = AppTheme.textPrimary;
    if (isAlert) textColor = AppTheme.statusDanger;
    if (isActionable) textColor = AppTheme.accentAmber;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: const TextStyle(
                      color: AppTheme.textSecondary, fontSize: 13))),
          Expanded(
              child: Text(val ?? 'N/A',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: (isAlert || isActionable)
                          ? FontWeight.bold
                          : FontWeight.normal))),
        ],
      ),
    );
  }

  Widget _metricBox(String title, String val) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppTheme.surfaceColor, borderRadius: BorderRadius.circular(6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
          const SizedBox(height: 2),
          Text(val,
              style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  InputDecoration _profileInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
      enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.cardColor)),
      focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppTheme.accentAmber)),
      contentPadding: const EdgeInsets.all(10),
    );
  }

  // ==========================================
  // 5. THE "FAST ORDER" BRIDGE (CONTEXT-AWARE)
  // ==========================================
  void _showFastOrderModal(Client client) {
    final amountController = TextEditingController();

    // Auto-load contexts
    String selectedWorkflow =
        client.clientType == 'wholesale' ? 'Wholesale' : 'Retail';
    String newClientType = 'retail';
    DateTime? targetDate;

    // Dynamically derive pricing tier based on client type
    String pricingTier = 'Standard Retail';
    if (client.clientType == 'wholesale') pricingTier = 'Wholesale (Tier 1)';
    if (client.clientType == 'custom_b2b') pricingTier = 'Contract / Custom';

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
      backgroundColor: AppTheme.bgColor,
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
                  top: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('New Order: ${client.name}',
                        style: const TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),

                    // --- NEW: AUTO-LOADED CONTEXT DASHBOARD ---
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppTheme.surfaceColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppTheme.cardColor)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Account Type',
                                  style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 12)),
                              Text(
                                  client.isLead
                                      ? 'Lead (Pending Conversion)'
                                      : _formatUIText(client.clientType),
                                  style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Pricing Tier',
                                  style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 12)),
                              Text(
                                  client.isLead
                                      ? 'Standard Retail'
                                      : pricingTier,
                                  style: const TextStyle(
                                      color: AppTheme.accentBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Payment Terms',
                                  style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 12)),
                              Text(
                                  client.isLead
                                      ? 'Immediate Payment'
                                      : (client.paymentTerms ??
                                          'Immediate Payment'),
                                  style: const TextStyle(
                                      color: AppTheme.accentAmber,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                            ],
                          ),
                          if (client.remainingCredit != null) ...[
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Available Credit',
                                    style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 12)),
                                Text('₹${client.remainingCredit}',
                                    style: TextStyle(
                                        color: client.remainingCredit! < 0
                                            ? AppTheme.statusDanger
                                            : AppTheme.statusSuccess,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13)),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // LEAD CONVERSION INJECTOR
                    if (client.isLead) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: AppTheme.accentBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.accentBlue)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lead Auto-Conversion',
                                style: TextStyle(
                                    color: AppTheme.accentBlue,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: AppTheme.cardColor,
                              value: newClientType,
                              style:
                                  const TextStyle(color: AppTheme.textPrimary),
                              decoration:
                                  _inputDecoration('Assign New Account Type'),
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

                    // DATA ENTRY
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: _inputDecoration('Total Order Amount (₹)'),
                    ),
                    const SizedBox(height: 16),

                    // TARGET DATE PICKER
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().add(const Duration(days: 7)),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null)
                          setModalState(() => targetDate = picked);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        decoration: BoxDecoration(
                            color: AppTheme.bgColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppTheme.cardColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                targetDate == null
                                    ? 'Expected Completion Date'
                                    : 'Due: ${targetDate.toString().split(' ')[0]}',
                                style: TextStyle(
                                    color: targetDate == null
                                        ? AppTheme.textSecondary
                                        : AppTheme.textPrimary,
                                    fontSize: 13)),
                            const Icon(Icons.calendar_month,
                                color: AppTheme.accentAmber, size: 18),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      dropdownColor: AppTheme.cardColor,
                      value: selectedWorkflow,
                      style: const TextStyle(color: AppTheme.textPrimary),
                      decoration: _inputDecoration('Order Workflow Pipeline'),
                      items: workflowTemplates.keys
                          .map((String value) => DropdownMenuItem(
                              value: value, child: Text(value)))
                          .toList(),
                      onChanged: (newValue) =>
                          setModalState(() => selectedWorkflow = newValue!),
                    ),
                    const SizedBox(height: 24),

                    // SUBMIT BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.statusSuccess,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (amountController.text.isNotEmpty) {
                            ref.read(orderProvider.notifier).addOrder(
                                  client.id,
                                  client.name ?? 'Unknown',
                                  double.tryParse(amountController.text) ?? 0.0,
                                  workflowTemplates[selectedWorkflow]!,
                                  newClientType:
                                      client.isLead ? newClientType : null,
                                  expectedCompletionDate:
                                      targetDate, // Passes the target date to the engine!
                                );
                            ref.read(crmProvider.notifier).loadClients();
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Confirm & Create Order',
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

  // ==========================================
  // 6. MAIN BUILD & QUICK ACTIONS
  // ==========================================
  void _executeQuickAction(String action, Client client) {
    if (action == 'Create Order') {
      _showFastOrderModal(client);
      return;
    }
    if (action == 'Add Note' || action == 'Add Follow-up') {
      _showQuickLogDialog(action, client);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Launching native $action system for ${client.name}...'),
      backgroundColor: AppTheme.accentAmber,
      duration: const Duration(seconds: 1),
    ));
    ref
        .read(crmProvider.notifier)
        .logInteraction(client.id, action, '$action initiated');
  }

  void _showQuickLogDialog(String action, Client client) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Text('$action - ${client.name}',
            style: const TextStyle(color: AppTheme.textPrimary)),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: AppTheme.textPrimary),
          decoration: InputDecoration(
            labelText: action == 'Add Note'
                ? 'Enter notes'
                : 'Enter follow-up details',
            labelStyle: const TextStyle(color: AppTheme.textSecondary),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppTheme.cardColor)),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: AppTheme.textSecondary))),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: AppTheme.accentAmber),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(crmProvider.notifier).logInteraction(
                    client.id,
                    action == 'Add Note' ? 'Note' : 'Follow-up',
                    controller.text);
                Navigator.pop(context);
              }
            },
            child:
                const Text('Save', style: TextStyle(color: AppTheme.bgColor)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rawClients = ref.watch(crmProvider);
    final processedClients = _getFilteredClients(rawClients);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Master'),
        actions: [
          IconButton(
            icon: Icon(_isTableView ? Icons.grid_view : Icons.table_rows,
                color: AppTheme.textPrimary),
            onPressed: () => setState(() => _isTableView = !_isTableView),
          ),
          IconButton(
            icon: const Icon(Icons.person_add, color: AppTheme.accentAmber),
            onPressed: _showAddClientForm,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: AppTheme.textPrimary),
                    onChanged: (val) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search Name, Business, Phone...',
                      hintStyle: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14),
                      prefixIcon: const Icon(Icons.search,
                          color: AppTheme.textSecondary),
                      filled: true,
                      fillColor: AppTheme.cardColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.filter_list,
                      color: (_filterStage != null ||
                              _filterType != null ||
                              _filterOutstandingOnly ||
                              _filterStatus != 'Active')
                          ? AppTheme.accentAmber
                          : AppTheme.textPrimary),
                  onPressed: _showFilterDrawer,
                )
              ],
            ),
          ),
          Expanded(
            child: processedClients.isEmpty
                ? const Center(
                    child: Text('No matching records found.',
                        style: TextStyle(color: AppTheme.textSecondary)))
                : _isTableView
                    ? _buildTableView(processedClients)
                    : _buildCardView(processedClients),
          ),
        ],
      ),
    );
  }

  Widget _buildCardView(List<Client> clients) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        final client = clients[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12.0),
          child: InkWell(
            onTap: () => _showClientProfile(client),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                              client.businessName?.isNotEmpty == true
                                  ? '${client.businessName} (${client.name})'
                                  : (client.name ?? 'Unknown'),
                              style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis)),
                      Row(
                        children: [
                          // Lead Source or Health Status Badge
                          if (client.isLead)
                            _buildPill('Lead', AppTheme.accentBlue)
                          else
                            _buildPill('${client.healthStatus} ♥',
                                _getHealthColor(client.healthStatus)),
                          const SizedBox(width: 4),
                          _buildPill(client.status ?? 'Active',
                              _getStatusColor(client.status)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                      client.isLead
                          ? 'Source: ${client.leadSource ?? 'N/A'}'
                          : 'Type: ${_formatUIText(client.clientType)}',
                      style: const TextStyle(
                          color: AppTheme.textSecondary, fontSize: 14)),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child:
                          Divider(color: AppTheme.surfaceColor, thickness: 1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Orders: ${client.totalOrders}',
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 13)),
                      Text('Outstanding: ₹${client.outstandingAmount}',
                          style: TextStyle(
                              color: client.outstandingAmount > 0
                                  ? AppTheme.statusDanger
                                  : AppTheme.textSecondary,
                              fontSize: 13,
                              fontWeight: client.outstandingAmount > 0
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                    ],
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child:
                          Divider(color: AppTheme.surfaceColor, thickness: 1)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _quickActionButton(Icons.phone, 'Call',
                          () => _executeQuickAction('Call', client)),
                      _quickActionButton(Icons.chat, 'WhatsApp',
                          () => _executeQuickAction('WhatsApp', client)),
                      _quickActionButton(Icons.email, 'Email',
                          () => _executeQuickAction('Email', client)),
                      _quickActionButton(Icons.note_add, 'Note',
                          () => _executeQuickAction('Add Note', client)),
                      _quickActionButton(Icons.add_shopping_cart, 'Order',
                          () => _executeQuickAction('Create Order', client),
                          isPrimary: true),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _quickActionButton(IconData icon, String label, VoidCallback onTap,
      {bool isPrimary = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          children: [
            Icon(icon,
                color:
                    isPrimary ? AppTheme.accentAmber : AppTheme.textSecondary,
                size: 20),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    color: isPrimary
                        ? AppTheme.accentAmber
                        : AppTheme.textSecondary,
                    fontSize: 10,
                    fontWeight:
                        isPrimary ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildTableView(List<Client> clients) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(AppTheme.cardColor),
          showCheckboxColumn: false,
          columnSpacing: 20,
          columns: const [
            DataColumn(
                label: Text('Name',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Business',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Relationship',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Type',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Status',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Phone',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Location',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Outstanding',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Last Order',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Next Follow-up',
                    style: TextStyle(
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.bold))),
          ],
          rows: clients.map((client) {
            return DataRow(
              onSelectChanged: (_) => _showClientProfile(client),
              cells: [
                DataCell(Text(client.name ?? '',
                    style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600))),
                DataCell(Text(client.businessName ?? '-',
                    style: const TextStyle(color: AppTheme.textPrimary))),
                DataCell(_buildPill(_formatUIText(client.relationshipStage),
                    _getStageColor(client.relationshipStage))),
                DataCell(Text(_formatUIText(client.clientType))),
                DataCell(_buildPill(
                    client.status ?? 'Active', _getStatusColor(client.status))),
                DataCell(Text(client.phone ?? '-')),
                DataCell(Text(client.location ?? '-')),
                DataCell(Text('₹${client.outstandingAmount}',
                    style: TextStyle(
                        color: client.outstandingAmount > 0
                            ? AppTheme.statusDanger
                            : AppTheme.textPrimary,
                        fontWeight: client.outstandingAmount > 0
                            ? FontWeight.bold
                            : FontWeight.normal))),
                DataCell(Text(
                    client.lastOrderDate?.toString().split(' ')[0] ?? '-')),
                DataCell(Text(
                    client.nextFollowUpDate?.toString().split(' ')[0] ?? '-')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
