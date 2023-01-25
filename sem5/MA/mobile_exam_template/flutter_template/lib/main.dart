import 'package:flutter/material.dart';
import 'package:flutter_template/networking/rest_client.dart';
import 'package:flutter_template/repo/entity_repo.dart';
import 'package:flutter_template/screens/home/home_screen.dart';
import 'package:flutter_template/theme/app_colors.dart';
import 'package:dio/dio.dart' show Dio;
import './database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('flutter_database.db').build();
  final dao = database.entityDao;

  EntityRepo.entityDao = dao;
  final dio = Dio();

  EntityRepo.client = RestClient(dio);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Books Library App',
      theme: ThemeData(
          primarySwatch: AppColors.primarySwatch,
          backgroundColor: AppColors.backgroundColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          dialogTheme: Theme.of(context).dialogTheme.copyWith(
                backgroundColor: const Color(0xFF262626),
                titleTextStyle: const TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
                contentTextStyle:
                    const TextStyle(color: Colors.white60, fontSize: 16),
              )),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
