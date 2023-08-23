import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:clean_architecture_riverpod/src/data/datasource/local/app_database.dart';
import 'package:clean_architecture_riverpod/src/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

import 'data/repositories/orders_repository_impl.dart';
import 'utils/constants/strings.dart';
import 'view/providers/orders_provider.dart';

final dio = Dio();
late AppDatabase db;

Future<List<InheritedProvider>> getProviders() async {
  dio.interceptors.add(AwesomeDioInterceptor());
  db = await $FloorAppDatabase.databaseBuilder(databaseName).build();

  return [
    Provider<Dio>(
      create: (context) => dio,
    ),
    Provider<AppDatabase>(
      create: (context) => db,
    ),
    Provider<OrderRepository>(
      create: (context) => OrdersRepositoryImpl(
        context.read<AppDatabase>(),
      ),
    ),
    ChangeNotifierProvider(
      create: (context) => OrdersProvider(
        context.read<OrderRepository>(),
      ),
    ),

    // Provider<OrdersService>(
    //   create: (context) => OrdersService(
    //     context.read<Dio>(),
    //   ),
    // ),
    // Provider<OrderRepository>(
    //   create: (context) => OrdersRepositoryImpl(
    //     context.read<OrdersService>(),
    //   ),
    // ),
  ];
}
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