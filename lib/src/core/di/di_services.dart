import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/stats/domain/services/stat_service.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerServices() async {
  final transactionDatasourceInst = getIt<TransactionDatasource>();
  final financialSummaryDatasourceInst = getIt<FinancialSummaryDatasource>();

  getIt.registerLazySingleton<TransactionService>(() =>
      TransactionService(transactionDatasource: transactionDatasourceInst));

  getIt.registerLazySingleton<StatService>(() => StatService());

  getIt.registerLazySingleton<FinancialSummaryService>(() =>
      FinancialSummaryService(datasource: financialSummaryDatasourceInst));
}
