import 'package:isar/isar.dart';
part 'order.g.dart';

@collection
class Order {
  Id id = Isar.autoIncrement;

  @Index()
  int? clientId;

  // Pipeline Statuses: 'Draft' -> 'Confirmed' -> 'Dispatched' -> 'Delivered' -> 'Paid' -> 'Cancelled'
  @Index()
  String? status;

  DateTime? date; // When the order was initially created
  String? notes;

  // --- NEW: Pipeline Timestamps ---
  DateTime? confirmedAt;
  DateTime? dispatchedAt;
  DateTime? deliveredAt;
  DateTime? paidAt;
  // --- THE NEW FIELD ---
  double deliveryCost = 0.0;
}
