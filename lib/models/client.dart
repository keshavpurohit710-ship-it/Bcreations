import 'package:isar/isar.dart';
part 'client.g.dart';

@collection
class Client {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  String? name;
  @Index(type: IndexType.value, caseSensitive: false)
  String? businessName;
  @Index(type: IndexType.value)
  String? phone;
  String? email;
  @Index(type: IndexType.value, caseSensitive: false)
  String? location;

  @Index(type: IndexType.value)
  String? relationshipStage;
  @Index(type: IndexType.value)
  String? clientType;
  @Index(type: IndexType.value)
  String? status;
  String? leadSource;

  @Index(type: IndexType.value)
  DateTime? nextFollowUpDate;
  DateTime? lastContactDate;
  String? followUpNotes;
  String? notes;

  // --- ORDERS MATH ---
  int totalOrders = 0;
  DateTime? lastOrderDate;
  DateTime? lastCompletedOrderDate;
  double lastOrderAmount = 0.0;
  double totalRevenue = 0.0;
  int openOrders = 0;

  @ignore
  double get averageOrderValue =>
      totalOrders > 0 ? totalRevenue / totalOrders : 0.0;
  @ignore
  bool get isLead => totalOrders == 0;

  // --- FINANCE MATH (Bulletproof Single Source of Truth) ---
  double outstandingAmount = 0.0;
  double overdueAmount = 0.0; // NEW
  DateTime? lastPaymentDate; // NEW
  double? creditLimit; // Editable
  String? paymentTerms; // Editable

  // NEW: Dynamically calculated, never stored
  @ignore
  double? get remainingCredit =>
      creditLimit != null ? creditLimit! - outstandingAmount : null;

  List<InteractionRecord> interactionHistory = [];

  // --- NEW: CRM RISK SCORING ENGINE ---
  @ignore
  String get healthStatus {
    if (status == 'Inactive' || status == 'Archived') return 'Inactive';
    if (isLead) return 'Lead'; // Leads don't get operational health scores

    int score = 100;
    final now = DateTime.now();

    // 1. Debt Penalty (High Severity)
    if (overdueAmount > 0) {
      score -= 30; // Immediate massive hit for owing overdue money
    }

    // 2. Dormancy Penalty (Medium Severity)
    if (lastOrderDate != null) {
      final daysSinceOrder = now.difference(lastOrderDate!).inDays;
      if (daysSinceOrder > 90)
        score -= 30;
      else if (daysSinceOrder > 45) score -= 15;
    }

    // 3. Communication Breakdown (Low/Medium Severity)
    if (nextFollowUpDate != null && nextFollowUpDate!.isBefore(now)) {
      final daysIgnored = now.difference(nextFollowUpDate!).inDays;
      if (daysIgnored > 7)
        score -= 20; // You are ignoring a scheduled follow up
      else if (daysIgnored > 0) score -= 10;
    }

    // 4. Cancelled Order Penalty (if we added cancellation counting later, this goes here)

    // Output Categorization
    if (score >= 80) return 'Healthy';
    if (score >= 50) return 'Attention Needed';
    return 'High Risk';
  }
}

@embedded
class InteractionRecord {
  DateTime? timestamp;
  String? interactionType;
  String? description;
}
