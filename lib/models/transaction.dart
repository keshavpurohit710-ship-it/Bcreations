import 'package:isar/isar.dart';

part 'transaction.g.dart'; // The red line appears, we fix it in Step 2

@collection
class Transaction {
  Id id = Isar.autoIncrement;

  DateTime? date;

  @Index(type: IndexType.value)
  String? description; // e.g., "Steel Tubing" or "Payment from Meta Infotech"

  double amount = 0.0;
  String? type; // 'Income' or 'Expense'
  String? category; // 'Procurement', 'Sales', 'Logistics', 'Overhead'
}
