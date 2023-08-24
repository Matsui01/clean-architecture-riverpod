import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../../provider.dart';
import 'base/base_state.dart';

final orderProvider = StateNotifierProvider<OrdersProvider, BaseState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrdersProvider(repository);
});

class OrdersProvider extends StateNotifier<BaseState> {
  final OrderRepository _orderRepository;

  OrdersProvider(this._orderRepository) : super(StateSuccess());

  Future<void> getOrders() async {
    state = StateLoading();
    state = await _getOrders();
  }

  Future<void> removeOrder({required Order order}) async {
    state = StateLoading();
    await _orderRepository.removeOrder(order);
    state = await _getOrders();
  }

  Future<void> saveOrder({required Order order}) async {
    state = StateLoading();
    await _orderRepository.saveOrder(order);
    state = await _getOrders();
  }

  Future<BaseState> _getOrders() async {
    final orders = await _orderRepository.getOrders();
    return StateSuccess(data: orders);
  }
}
