import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/repositories/financial_summary_repository_impl.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/stats/data/datasources/stats_repository_impl.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/domain/services/stat_service.dart';
import 'package:flutter_money_manager/src/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerRepositories() async {
  final transactionService = getIt<TransactionService>();
  final financialSummaryService = getIt<FinancialSummaryService>();
  final financialSummaryDatasourceInst = getIt<FinancialSummaryDatasource>();

  getIt.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(
          financialSummaryService: financialSummaryService,
          transactionService: transactionService));

  getIt.registerLazySingleton<FinancialSummaryRepository>(() =>
      FinancialSummaryRepositoryImpl(
          datasource: financialSummaryDatasourceInst));

  getIt.registerLazySingleton<StatsRepository>(() => StatsRepositoryImpl(
      transactionService: transactionService,
      financialSummaryService: financialSummaryService,
      statService: getIt<StatService>()));
}
