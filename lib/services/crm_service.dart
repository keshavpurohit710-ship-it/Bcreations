import 'package:isar/isar.dart';
import '../domain/models/client.dart';

class CrmService {
  final Isar _isar;
  CrmService(this._isar);

  /// ACTION: Safely adds a new Lead or Client while preventing duplicates
  Future<void> addClient({
    required String name,
    required String businessName,
    required String type,
    String? phone,
    String? email,
    String? location,
  }) async {
    // 1. THE DUPLICATION GUARD: Check if the business name already exists
    final existingClient = await _isar.clients
        .filter()
        .businessNameEqualTo(businessName, caseSensitive: false)
        .findFirst();

    if (existingClient != null) {
      // If it exists, we throw an error. The UI will catch this and show a red snackbar!
      throw Exception(
          'A client/lead with the business name "$businessName" already exists.');
    }

    // 2. If it is unique, create the record
    final newClient = Client()
      ..name = name
      ..businessName = businessName
      ..type = type // 'Lead' or 'Client'
      ..phone = phone
      ..email = email
      ..location = location
      ..createdAt = DateTime.now();

    // 3. Save to Database
    await _isar.writeTxn(() async {
      await _isar.clients.put(newClient);
    });
  }
}
