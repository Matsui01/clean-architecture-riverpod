import 'package:clean_architecture_riverpod/src/data/datasource/local/app_database.dart';
import 'package:clean_architecture_riverpod/src/domain/repositories/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repositories/orders_repository_impl.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError();
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final db = ref.watch(dbProvider);
  return OrdersRepositoryImpl(db);
});


/*
final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  getIt.registerSingleton<AppDatabase>(db);

  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<OrdersService>(
    OrdersService(getIt<Dio>()),
  );

  getIt.registerSingleton<OrderRepository>(
    OrdersRepositoryImpl(getIt<AppDatabase>()),
  );
}

*/
