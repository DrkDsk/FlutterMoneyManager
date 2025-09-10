import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_bloc.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
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

  getIt.registerLazySingleton<TransactionDatasource>(() =>
      TransactionDatasourceImpl(
          transactionSourceBox: transactionsSourceBox,
          globalBalanceBox: globalBalanceBox,
          transactionsYearBox: transactionsYearBox,
          yearBalanceBox: yearBalanceBox));

  getIt.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(datasource: getIt<TransactionDatasource>()));

  final transactionRepositoryInst = getIt<TransactionRepository>();

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<HomeRedirectionCubit>(() => HomeRedirectionCubit());
  getIt.registerFactory<CreateTransactionCubit>(
      () => CreateTransactionCubit(repository: transactionRepositoryInst));

  getIt.registerFactory<TransactionsBloc>(
      () => TransactionsBloc(repository: transactionRepositoryInst));

  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(repository: transactionRepositoryInst));
  getIt.registerFactory<AccountBloc>(
      () => AccountBloc(transactionRepository: transactionRepositoryInst));
  getIt.registerFactory<StatsBloc>(
      () => StatsBloc(repository: transactionRepositoryInst));
}
