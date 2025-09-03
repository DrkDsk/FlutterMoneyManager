import 'package:flutter_money_manager/src/core/helpers/hive_initializer.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/bloc/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final box = await HiveInitializer.init();

  getIt.registerSingleton(box);

  getIt.registerLazySingleton<TransactionDatasource>(
      () => TransactionDatasourceImpl(box: box));

  getIt.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(datasource: getIt<TransactionDatasource>()));

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<HomeRedirectionCubit>(() => HomeRedirectionCubit());
  getIt.registerFactory<CreateTransactionCubit>(
      () => CreateTransactionCubit(repository: getIt<TransactionRepository>()));

  getIt.registerFactory<GetTransactionsListCubit>(() =>
      GetTransactionsListCubit(repository: getIt<TransactionRepository>()));

  getIt.registerFactory<TransactionsBloc>(
      () => TransactionsBloc(repository: getIt<TransactionRepository>()));
}
