import 'package:clean_architecture_riverpod/src/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/config/router/app_router.dart';
import 'src/config/themes/app_themes.dart';
import 'src/data/datasource/local/app_database.dart';
import 'src/utils/constants/strings.dart';

final _dio = Dio();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();

  runApp(
    ProviderScope(
      overrides: [
        Provider<Dio>((_) => _dio),
        dbProvider.overrideWithValue(db),
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
