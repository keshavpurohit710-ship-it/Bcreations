import 'package:isar/isar.dart';
part 'transaction.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement;

  @Index()
  int? clientId; // Who paid us, or who we paid

  @Index()
  int? relatedOrderId; // If this payment is for a specific order

  DateTime? date;
  double amount = 0.0;

  @Index()
  String type = 'Income'; // 'Income' or 'Expense'

  String? category;
  String? paymentMethod;
}
