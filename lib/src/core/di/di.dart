import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_bloc.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/finanacial_summary_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/repositories/financial_summary_repository_impl.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/stats/data/datasources/stats_repository_impl.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/domain/services/stat_service.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await HiveHelper.init();

  final transactionsSourceBox = await HiveHelper.getTransactionsSourceBox();
  final globalBalanceBox = await HiveHelper.getGlobalTransactionHiveBox();
  final yearBalanceBox = await HiveHelper.getBalanceYearHiveBox();
  final transactionsYearBox = await HiveHelper.getTransactionYearHiveBox();

  getIt.registerLazySingleton<FinancialSummaryDatasource>(() =>
      FinancialSummaryDatasourceImpl(
          transactionSourceBox: transactionsSourceBox,
          globalBalanceBox: globalBalanceBox,
          yearBalanceBox: yearBalanceBox,
          transactionsYearBox: transactionsYearBox));

  getIt.registerLazySingleton<TransactionDatasource>(() =>
      TransactionDatasourceImpl(
          transactionSourceBox: transactionsSourceBox,
          globalBalanceBox: globalBalanceBox,
          transactionsYearBox: transactionsYearBox,
          yearBalanceBox: yearBalanceBox));

  final transactionDatasourceInst = getIt<TransactionDatasource>();
  final financialSummaryDatasourceInst = getIt<FinancialSummaryDatasource>();

  getIt.registerLazySingleton<TransactionService>(() => TransactionService(
      transactionDatasource: transactionDatasourceInst,
      financialSummaryDatasource: financialSummaryDatasourceInst));

  getIt.registerLazySingleton<StatService>(() => StatService());

  final transactionService = getIt<TransactionService>();

  getIt.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(
          transactionDatasource: transactionDatasourceInst,
          financialSummaryDatasource: financialSummaryDatasourceInst,
          transactionService: transactionService));

  getIt.registerLazySingleton<FinancialSummaryRepository>(() =>
      FinancialSummaryRepositoryImpl(
          datasource: financialSummaryDatasourceInst));

  getIt.registerLazySingleton<StatsRepository>(() => StatsRepositoryImpl(
      transactionService: transactionService,
      statService: getIt<StatService>()));

  final transactionRepositoryInst = getIt<TransactionRepository>();
  final financialSummaryRepositoryInst = getIt<FinancialSummaryRepository>();

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<HomeRedirectionCubit>(() => HomeRedirectionCubit());
  getIt.registerFactory<CreateTransactionCubit>(
      () => CreateTransactionCubit(repository: transactionRepositoryInst));

  getIt.registerFactory<TransactionsBloc>(
      () => TransactionsBloc(repository: transactionRepositoryInst));

  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(repository: transactionRepositoryInst));

  getIt.registerFactory<AccountBloc>(() => AccountBloc(
      transactionRepository: transactionRepositoryInst,
      financialSummaryRepository: financialSummaryRepositoryInst));

  getIt.registerFactory<StatsBloc>(
      () => StatsBloc(repository: getIt<StatsRepository>()));
}
