import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../main.dart';
import '../../models/client.dart';

final crmProvider = StateNotifierProvider<CRMNotifier, List<Client>>((ref) {
  return CRMNotifier();
});

class CRMNotifier extends StateNotifier<List<Client>> {
  CRMNotifier() : super([]) {
    loadClients();
  }

  Future<void> loadClients() async {
    final clients =
        await isar.clients.filter().not().statusEqualTo('Archived').findAll();
    state = clients;
  }

  Future<Client?> checkDuplicate(
      {String? phone,
      String? email,
      String? name,
      String? businessName}) async {
    if (phone != null && phone.isNotEmpty) {
      final match = await isar.clients.filter().phoneEqualTo(phone).findFirst();
      if (match != null) return match;
    }
    if (email != null && email.isNotEmpty) {
      final match = await isar.clients.filter().emailEqualTo(email).findFirst();
      if (match != null) return match;
    }
    if (name != null &&
        name.isNotEmpty &&
        businessName != null &&
        businessName.isNotEmpty) {
      final matches = await isar.clients
          .filter()
          .nameEqualTo(name)
          .and()
          .businessNameEqualTo(businessName)
          .findAll();
      if (matches.isNotEmpty) return matches.first;
    }
    return null;
  }

  Future<void> addClient({
    required String name,
    required String phone,
    required String businessName,
    required String email,
    required String location,
    required String relationshipStage,
    String? clientType,
    String? leadSource,
  }) async {
    final initialLog = InteractionRecord()
      ..timestamp = DateTime.now()
      ..interactionType = 'System'
      ..description = 'Created as $relationshipStage';

    final newClient = Client()
      ..name = name
      ..phone = phone
      ..businessName = businessName
      ..email = email
      ..location = location
      ..relationshipStage = relationshipStage
      ..clientType = clientType
      ..leadSource = leadSource
      ..status = 'Active'
      ..totalOrders = 0
      ..outstandingAmount = 0.0
      ..interactionHistory = [initialLog];

    await isar.writeTxn(() async {
      await isar.clients.put(newClient);
    });

    await loadClients();
  }

  // --- UPGRADED UPDATER (Fixes editing and unarchiving) ---
  Future<void> updateClientDetails(int clientId,
      {String? name,
      String? businessName,
      String? phone,
      String? email,
      String? location,
      String? clientType,
      String? leadSource,
      String? notes,
      String? paymentTerms,
      double? creditLimit,
      String? status,
      DateTime? nextFollowUpDate // <-- NEW PARAMETER
      }) async {
    await isar.writeTxn(() async {
      final client = await isar.clients.get(clientId);
      if (client != null) {
        if (name != null) client.name = name;
        if (businessName != null) client.businessName = businessName;
        if (phone != null) client.phone = phone;
        if (email != null) client.email = email;
        if (location != null) client.location = location;

        if (clientType != null) client.clientType = clientType;
        if (leadSource != null) client.leadSource = leadSource;
        if (notes != null) client.notes = notes;
        if (paymentTerms != null) client.paymentTerms = paymentTerms;
        if (creditLimit != null) client.creditLimit = creditLimit;

        // TIMELINE LOG: Follow-up Scheduled
        if (nextFollowUpDate != null &&
            client.nextFollowUpDate != nextFollowUpDate) {
          client.nextFollowUpDate = nextFollowUpDate;
          final fLog = InteractionRecord()
            ..timestamp = DateTime.now()
            ..interactionType = 'Follow-up'
            ..description =
                'Follow-up scheduled for ${nextFollowUpDate.toString().split(' ')[0]}';
          client.interactionHistory = [...client.interactionHistory, fLog];
        }

        if (status != null && client.status != status) {
          client.status = status;
          final record = InteractionRecord()
            ..timestamp = DateTime.now()
            ..interactionType = 'System'
            ..description = 'Status changed to $status';
          client.interactionHistory = [...client.interactionHistory, record];
        }

        await isar.clients.put(client);
      }
    });
    await loadClients();
  }

  Future<void> logInteraction(
      int clientId, String type, String description) async {
    await isar.writeTxn(() async {
      final client = await isar.clients.get(clientId);
      if (client != null) {
        final newRecord = InteractionRecord()
          ..timestamp = DateTime.now()
          ..interactionType = type
          ..description = description;

        client.interactionHistory = [...client.interactionHistory, newRecord];
        client.lastContactDate = DateTime.now();
        await isar.clients.put(client);
      }
    });
    await loadClients();
  }
}
