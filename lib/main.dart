import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(const MyApp());
}
