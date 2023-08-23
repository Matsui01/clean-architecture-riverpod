import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:clean_architecture_riverpod/src/data/datasource/local/app_database.dart';
import 'package:clean_architecture_riverpod/src/domain/repositories/order_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_themes.dart';
import 'src/data/repositories/orders_repository_impl.dart';
import 'src/utils/constants/strings.dart';
import 'src/view/providers/orders_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());
  AppDatabase db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  // await initializeDependencies();
  // final providers = await getProviders();
  runApp(
    MultiProvider(
      providers: [
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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Clean Architecture Provider',
      theme: AppTheme.light,
      routerConfig: _appRouter.config(),
    );
  }
}
