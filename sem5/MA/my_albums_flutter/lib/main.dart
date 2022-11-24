import 'package:flutter/material.dart';
import 'package:my_albums_flutter/screens/home/home_screen.dart';
import 'package:my_albums_flutter/theme/app_colors.dart';

void main() {
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
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
