import 'package:auto_route/auto_route.dart';
import 'package:clean_architecture_riverpod/src/view/providers/base/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/models/order.dart';
import '../providers/orders_provider.dart';

@RoutePage()
class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrdersProvider>().getOrders();
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
          context.read<OrdersProvider>().saveOrder(
                order: const Order(description: 'Pedido'),
              );
        },
      ),
      body: Builder(
        builder: (context) {
          BaseState state = context.watch<OrdersProvider>().state;
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
      onRefresh: () => context.read<OrdersProvider>().getOrders(),
      child: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${orders[index].description ?? ''} ${orders[index].id} 😀'),
            onTap: () {},
            leading: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => context.read<OrdersProvider>().removeOrder(order: orders[index]),
            ),
          );
        },
      ),
    );
  }
}
