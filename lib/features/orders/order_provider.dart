import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../core/providers/core_providers.dart';
import '../../domain/models/order.dart';

final activeOrdersProvider = FutureProvider<List<Order>>((ref) async {
  ref.watch(orderWatcher); // <--- THE HEARTBEAT
  final isar = ref.read(isarProvider);
  return await isar.orders
      .filter()
      .statusEqualTo('Draft')
      .or()
      .statusEqualTo('Active')
      .findAll();
});
