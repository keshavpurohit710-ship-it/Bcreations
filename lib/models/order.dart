import 'package:isar/isar.dart';
part 'order.g.dart';

@collection
class Order {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  String? orderNumber;
  @Index(type: IndexType.value)
  int? clientId;
  String? clientName;

  double totalAmount = 0.0;
  DateTime? date;
  DateTime? expectedCompletionDate;

  // --- NEW: FINANCE TRACKING ---
  DateTime? paymentDueDate;

  List<String>? stages;
  int currentStageIndex = 0;

  @Index(type: IndexType.value)
  String orderStatus = 'Active';
  bool isPaid = false;
}
