import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/di/di.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_initializer.dart';
import 'package:flutter_money_manager/src/my_app.dart';

void main() async {
  await initDependencies();
  await HiveInitializer.init();

  runApp(const MyApp());
}
