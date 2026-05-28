import 'package:isar/isar.dart';
part 'client.g.dart';

@collection
class Client {
  Id id = Isar.autoIncrement;

  @Index(caseSensitive: false)
  String? name;

  @Index(caseSensitive: false)
  String? businessName;

  String? phone;
  String? email;
  String? location;

  // This defines if they are a Lead, Client, or Vendor
  @Index()
  String type = 'Lead';

  // Safe archiving ensures you can always unarchive someone
  @Index()
  bool isArchived = false;

  DateTime? createdAt;
  String? notes;
}
