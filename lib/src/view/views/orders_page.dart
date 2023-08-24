import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture_riverpod/src/view/providers/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/order.dart';
import '../providers/orders_provider.dart';

@RoutePage()
class OrdersPage extends ConsumerStatefulWidget {
  const OrdersPage({super.key});

  @override
  ConsumerState<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends ConsumerState<OrdersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(orderProvider.notifier).getOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("App")),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Pedido'),
        icon: const Icon(Icons.add),
        onPressed: () {
          ref.read(orderProvider.notifier).saveOrder(
                order: const Order(description: 'Pedido'),
              );
        },
      ),
      body: Consumer(
        builder: (context, ref, child) {
          BaseState state = ref.watch(orderProvider);
          // BaseState state = ref.watch(OrdersProvider).state;
          switch (state.runtimeType) {
            case StateSuccess:
              if (state.data is List<Order>) {
                return _buildOrders(state.data);
              }
              return const Center(child: Text('Empty Page 😥'));
            case StateLoading:
              return const Center(child: CircularProgressIndicator());
            case StateFailed:
              return const Center(child: Icon(Icons.refresh));
            default:
              return const Center(child: Text('Empty Page 😥'));
          }
        },
      ),
    );
  }

  Widget _buildOrders(List<Order> orders) {
    return RefreshIndicator(
      onRefresh: () => ref.read(orderProvider.notifier).getOrders(),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${orders[index].description ?? ''} ${orders[index].id} 😀'),
            onTap: () {},
            leading: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => ref.read(orderProvider.notifier).removeOrder(order: orders[index]),
            ),
          );
        },
      ),
    );
  }
}
