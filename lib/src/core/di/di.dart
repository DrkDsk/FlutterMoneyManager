import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  final box = await Hive.openBox<TransactionHiveModel>(hiveTransactionBoxName);

  getIt.registerLazySingleton<TransactionDatasource>(
      () => TransactionDatasourceImpl(box: box));

  getIt.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(datasource: getIt<TransactionDatasource>()));

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<HomeRedirectionCubit>(() => HomeRedirectionCubit());
  getIt.registerFactory<CreateTransactionCubit>(
      () => CreateTransactionCubit(repository: getIt<TransactionRepository>()));
}
