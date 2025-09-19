import 'package:flutter_money_manager/src/core/di/di_blocs.dart';
import 'package:flutter_money_manager/src/core/di/di_boxes.dart';
import 'package:flutter_money_manager/src/core/di/di_datasources.dart';
import 'package:flutter_money_manager/src/core/di/di_repositories.dart';
import 'package:flutter_money_manager/src/core/di/di_services.dart';
import 'package:flutter_money_manager/src/core/di/di_use_cases.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerDependencies() async {
  await registerBoxes();
  await registerDataSources();
  await registerServices();
  await registerRepositories();
  await registerUseCases();
  await registerBlocs();
}
