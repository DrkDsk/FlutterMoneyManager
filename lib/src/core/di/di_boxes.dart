import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> registerBoxes() async {
  await HiveHelper.init();

  final transactionsBox = await HiveHelper.getTransactionsBox();
  final transactionsSourceBox = await HiveHelper.getTransactionsSourceBox();

  getIt.registerLazySingleton<Box<TransactionSourceHiveModel>>(
      () => transactionsSourceBox);
  getIt.registerLazySingleton<Box<TransactionHiveModel>>(() => transactionsBox);
}
