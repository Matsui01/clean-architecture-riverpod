import 'dart:async';

import 'package:clean_architecture_riverpod/src/view/providers/base/base_provider.dart';

import '../../domain/models/order.dart';
import '../../domain/repositories/order_repository.dart';
import 'base/base_state.dart';

class OrdersProvider extends BaseProvider {
  final OrderRepository _orderRepository;

  OrdersProvider(this._orderRepository) : super(state: StateSuccess());

  Future<void> getOrders() async {
    setScreenState(StateLoading());
    setScreenState(await _getOrders());
  }

  Future<void> removeOrder({required Order order}) async {
    setScreenState(StateLoading());
    await _orderRepository.removeOrder(order);
    setScreenState(await _getOrders());
  }

  Future<void> saveOrder({required Order order}) async {
    setScreenState(StateLoading());
    await _orderRepository.saveOrder(order);
    setScreenState(await _getOrders());
  }

  Future<BaseState> _getOrders() async {
    final orders = await _orderRepository.getOrders();
    return StateSuccess(data: orders);
  }
}
