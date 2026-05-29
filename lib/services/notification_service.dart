import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import '../domain/models/order.dart';
import 'finance_service.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final Isar _isar;
  final FinanceService _financeService;

  NotificationService(this._isar, this._financeService);

  /// 1. Initialize the native notification engine (Android Only)
  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    // We removed iOS (Darwin) settings since this is an Android-first build
    const initSettings = InitializationSettings(android: androidInit);

    // THE FIX: Use the named parameter 'settings:'
    await _plugin.initialize(settings: initSettings);

    // ANDROID 13+ FIX: Explicitly request permission to show notifications
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  /// 2. The Business Logic: Query for Unpaid Delivered Orders
  Future<void> checkPendingPayments() async {
    final deliveredOrders =
        await _isar.orders.filter().statusEqualTo('Delivered').findAll();
    final uniqueClientIds =
        deliveredOrders.map((o) => o.clientId).whereType<int>().toSet();

    int unpaidClientsCount = 0;
    double totalOverdue = 0.0;

    for (final clientId in uniqueClientIds) {
      final balance =
          await _financeService.getClientOutstandingBalance(clientId);
      if (balance > 0) {
        unpaidClientsCount++;
        totalOverdue += balance;
      }
    }

    if (unpaidClientsCount > 0) {
      await _showNotification(
        id: 1,
        title: 'Pending Payments Alert ⚠️',
        body:
            '$unpaidClientsCount clients have unpaid delivered orders totaling ₹${totalOverdue.toStringAsFixed(0)}.',
      );
    }
  }

  /// 3. Safely trigger the OS-level notification
  Future<void> _showNotification(
      {required int id, required String title, required String body}) async {
    const androidDetails = AndroidNotificationDetails(
      'finance_alerts', // Channel ID
      'Financial Alerts', // Channel Name
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    // THE FIX: Use named parameters (id:, title:, body:, notificationDetails:)
    await _plugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
