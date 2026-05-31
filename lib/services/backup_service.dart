import 'dart:convert';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../domain/models/client.dart';
import '../domain/models/inventory_item.dart';
import '../domain/models/order.dart';
import '../domain/models/order_line_item.dart';
import '../domain/models/stock_movement.dart';
import '../domain/models/transaction.dart';

class BackupService {
  final Isar _isar;
  BackupService(this._isar);

  // ==========================================
  // EXPORT
  // ==========================================
  Future<void> exportDatabaseToJson() async {
    final clients = await _isar.clients.where().findAll();
    final inventory = await _isar.inventoryItems.where().findAll();
    final orders = await _isar.orders.where().findAll();
    final orderItems = await _isar.orderLineItems.where().findAll();
    final stock = await _isar.stockMovements.where().findAll();
    final txs = await _isar.transactions.where().findAll();

    final backupData = {
      'export_timestamp': DateTime.now().toIso8601String(),
      'clients': clients
          .map((c) => {
                'id': c.id,
                'name': c.name,
                'businessName': c.businessName,
                'type': c.type,
                'location': c.location,
                'phone': c.phone,
                'email': c.email,
                'isArchived': c.isArchived
              })
          .toList(),
      'inventory': inventory
          .map((i) => {
                'id': i.id,
                'sku': i.sku,
                'name': i.name,
                'category': i.category,
                'unit': i.unit,
                'itemType': i.itemType,
                'minStockLevel': i.minStockLevel,
                'costPrice': i.costPrice
              })
          .toList(),
      'orders': orders
          .map((o) => {
                'id': o.id,
                'clientId': o.clientId,
                'status': o.status,
                'date': o.date?.toIso8601String(),
                // --- THE FIX: Added full pipeline timeline export ---
                'confirmedAt': o.confirmedAt?.toIso8601String(),
                'dispatchedAt': o.dispatchedAt?.toIso8601String(),
                'deliveredAt': o.deliveredAt?.toIso8601String(),
                'paidAt': o.paidAt?.toIso8601String(),
                'deliveryCost': o.deliveryCost
              })
          .toList(),
      'order_items': orderItems
          .map((oi) => {
                'id': oi.id,
                'orderId': oi.orderId,
                'inventoryItemId': oi.inventoryItemId,
                'quantity': oi.quantity,
                'pricePerUnit': oi.pricePerUnit,
                'unit': oi.unit
              })
          .toList(),
      'stock_movements': stock
          .map((s) => {
                'id': s.id,
                'inventoryItemId': s.inventoryItemId,
                'vendorId': s.vendorId,
                'quantityChange': s.quantityChange,
                'reason': s.reason,
                'date': s.date?.toIso8601String(),
                'totalCost': s.totalCost,
                'unitCost': s.unitCost
              })
          .toList(),
      'transactions': txs
          .map((t) => {
                'id': t.id,
                'clientId': t.clientId,
                'amount': t.amount,
                'type': t.type,
                'paymentMethod': t.paymentMethod,
                'description': t.description,
                'relatedOrderId': t.relatedOrderId,
                'date': t.date?.toIso8601String()
              })
          .toList(),
    };

    final jsonString = const JsonEncoder.withIndent('  ').convert(backupData);
    final tempDir = await getTemporaryDirectory();
    final fileName =
        'SoloBiz_Backup_${DateTime.now().millisecondsSinceEpoch}.json';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsString(jsonString);

    await Share.shareXFiles([XFile(file.path)],
        text: 'Business Database Backup');
  }

  // ==========================================
  // IMPORT / RESTORE
  // ==========================================
  Future<void> importDatabaseFromJson(String filePath) async {
    final file = File(filePath);
    final jsonString = await file.readAsString();
    final Map<String, dynamic> data = jsonDecode(jsonString);

    await _isar.writeTxn(() async {
      // 1. NUKE EXISTING DATA to prevent ID overlap and foreign key corruption
      await _isar.clear();

      // 2. Rebuild Clients
      if (data['clients'] != null) {
        final clients = (data['clients'] as List)
            .map((c) => Client()
              ..id = c['id']
              ..name = c['name']
              ..businessName = c['businessName']
              ..type = c['type']
              ..location = c['location']
              ..phone = c['phone']
              ..email = c['email']
              ..isArchived = c['isArchived'] ?? false)
            .toList();
        await _isar.clients.putAll(clients);
      }

      // 3. Rebuild Inventory
      if (data['inventory'] != null) {
        final inventory = (data['inventory'] as List)
            .map((i) => InventoryItem()
              ..id = i['id']
              ..sku = i['sku']
              ..name = i['name']
              ..category = i['category']
              ..unit = i['unit']
              ..itemType = i['itemType']
              ..minStockLevel = i['minStockLevel'] ?? 5
              ..costPrice = (i['costPrice'] ?? 0.0).toDouble())
            .toList();
        await _isar.inventoryItems.putAll(inventory);
      }

      // 4. Rebuild Orders
      if (data['orders'] != null) {
        final orders = (data['orders'] as List)
            .map((o) => Order()
              ..id = o['id']
              ..clientId = o['clientId']
              ..status = o['status']
              ..deliveryCost = (o['deliveryCost'] ?? 0.0).toDouble()
              // --- THE FIX: Added full pipeline timeline import ---
              ..confirmedAt = o['confirmedAt'] != null
                  ? DateTime.parse(o['confirmedAt'])
                  : null
              ..dispatchedAt = o['dispatchedAt'] != null
                  ? DateTime.parse(o['dispatchedAt'])
                  : null
              ..deliveredAt = o['deliveredAt'] != null
                  ? DateTime.parse(o['deliveredAt'])
                  : null
              ..paidAt =
                  o['paidAt'] != null ? DateTime.parse(o['paidAt']) : null
              ..date = o['date'] != null
                  ? DateTime.parse(o['date'])
                  : DateTime.now())
            .toList();
        await _isar.orders.putAll(orders);
      }

      // 5. Rebuild Order Items
      if (data['order_items'] != null) {
        final orderItems = (data['order_items'] as List)
            .map((oi) => OrderLineItem()
              ..id = oi['id']
              ..orderId = oi['orderId']
              ..inventoryItemId = oi['inventoryItemId']
              ..quantity = oi['quantity']
              ..unit = oi['unit']
              ..pricePerUnit = (oi['pricePerUnit'] ?? 0.0).toDouble())
            .toList();
        await _isar.orderLineItems.putAll(orderItems);
      }

      // 6. Rebuild Stock Movements
      if (data['stock_movements'] != null) {
        final stock = (data['stock_movements'] as List)
            .map((s) => StockMovement()
              ..id = s['id']
              ..inventoryItemId = s['inventoryItemId']
              ..vendorId = s['vendorId']
              ..quantityChange = s['quantityChange']
              ..reason = s['reason']
              ..date =
                  s['date'] != null ? DateTime.parse(s['date']) : DateTime.now()
              ..totalCost =
                  s['totalCost'] != null ? (s['totalCost']).toDouble() : null
              ..unitCost =
                  s['unitCost'] != null ? (s['unitCost']).toDouble() : null)
            .toList();
        await _isar.stockMovements.putAll(stock);
      }

      // 7. Rebuild Transactions
      if (data['transactions'] != null) {
        final txs = (data['transactions'] as List)
            .map((t) => Transaction()
              ..id = t['id']
              ..clientId = t['clientId']
              ..amount = (t['amount'] ?? 0.0).toDouble()
              ..type = t['type']
              ..paymentMethod = t['paymentMethod']
              ..description = t['description']
              ..relatedOrderId = t['relatedOrderId']
              ..date = t['date'] != null
                  ? DateTime.parse(t['date'])
                  : DateTime.now())
            .toList();
        await _isar.transactions.putAll(txs);
      }
    });
  }
}
