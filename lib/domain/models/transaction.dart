import 'package:isar/isar.dart';
part 'transaction.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement;
  int? clientId;
  late double amount;
  late String type;
  String? paymentMethod;

  // --- THE FIX: Dedicated Description Field ---
  String? description;

  int? relatedOrderId;
  late DateTime date;
}
