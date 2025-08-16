import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/theme/theme__helper.dart';
import 'package:flutter_money_manager/src/features/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      home: const HomeScreen(),
    );
  }
}