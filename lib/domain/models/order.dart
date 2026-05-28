import 'package:isar/isar.dart';
part 'order.g.dart';

@collection
class Order {
  Id id = Isar.autoIncrement;

  // This hard-links the order directly to the CRM
  @Index()
  int? clientId;

  DateTime? date;
  DateTime? expectedCompletionDate;

  @Index()
  String status = 'Draft'; // 'Draft', 'Active', 'Completed', 'Cancelled'

  String? notes;
}
