import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> registerBoxes() async {
  await HiveHelper.init();

  final transactionsSourceBox = await HiveHelper.getTransactionsSourceBox();
  final globalBalanceBox = await HiveHelper.getGlobalTransactionHiveBox();
  final yearBalanceBox = await HiveHelper.getBalanceYearHiveBox();
  final transactionsYearBox = await HiveHelper.getTransactionYearHiveBox();

  getIt.registerLazySingleton<Box<TransactionSourceHiveModel>>(
      () => transactionsSourceBox);
  getIt.registerLazySingleton<Box<FinancialSummaryHiveModel>>(
      () => globalBalanceBox);
  getIt.registerLazySingleton<Box<YearlyFinancialSummaryHiveModel>>(
      () => yearBalanceBox);
  getIt.registerLazySingleton<Box<YearlyTransactionsHiveModel>>(
      () => transactionsYearBox);
}
