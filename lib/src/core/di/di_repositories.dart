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
  final statService = getIt<StatService>();

  getIt.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(transactionService: transactionService));

  getIt.registerLazySingleton<FinancialSummaryRepository>(() =>
      FinancialSummaryRepositoryImpl(
          financialSummaryService: financialSummaryService));

  getIt.registerLazySingleton<StatsRepository>(() => StatsRepositoryImpl(
      transactionService: transactionService, statService: statService));
}
