import '../main.dart';
import '../domain/models/client.dart';

class ClientRepository {
  Future<Client?> getClient(int id) async {
    return await isar.clients.get(id);
  }

  Future<void> saveClient(Client client) async {
    await isar.writeTxn(() async {
      await isar.clients.put(client);
    });
  }
}
