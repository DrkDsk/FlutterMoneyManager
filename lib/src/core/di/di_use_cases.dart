import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_financial_summary_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_year_financial_summary_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_yearly_transaction_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerUseCases() async {
  final transactionRepositoryInst = getIt<TransactionRepository>();
  final financialSummaryRepositoryInst = getIt<FinancialSummaryRepository>();

  getIt.registerLazySingleton<SaveYearlyTransactionUseCase>(() =>
      SaveYearlyTransactionUseCase(repository: transactionRepositoryInst));

  getIt.registerLazySingleton<SaveYearFinancialSummaryUseCase>(() =>
      SaveYearFinancialSummaryUseCase(
          repository: financialSummaryRepositoryInst));

  getIt.registerLazySingleton<SaveFinancialSummaryUseCase>(() =>
      SaveFinancialSummaryUseCase(repository: financialSummaryRepositoryInst));
}
