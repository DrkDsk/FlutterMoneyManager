import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/finanacial_summary_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> registerDataSources() async {
  final transactionSourceBox = getIt<Box<TransactionSourceHiveModel>>();
  final transactionsYearBox = getIt<Box<YearlyTransactionsHiveModel>>();

  final globalBalanceBox = getIt<Box<FinancialSummaryHiveModel>>();
  final yearBalanceBox = getIt<Box<YearlyFinancialSummaryHiveModel>>();

  getIt.registerLazySingleton<TransactionDatasource>(
      () => TransactionDatasourceImpl(
            transactionSourceBox: transactionSourceBox,
            transactionsYearBox: transactionsYearBox,
          ));

  getIt.registerLazySingleton<FinancialSummaryDatasource>(() =>
      FinancialSummaryDatasourceImpl(
          globalBalanceBox: globalBalanceBox, yearBalanceBox: yearBalanceBox));
}
