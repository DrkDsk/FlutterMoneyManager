import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource_impl.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> registerDataSources() async {
  final transactionsBox = getIt<Box<TransactionHiveModel>>();
  final transactionSourceBox = getIt<Box<TransactionSourceHiveModel>>();

  getIt.registerLazySingleton<TransactionDatasource>(() =>
      TransactionDatasourceImpl(
          transactionSourceBox: transactionSourceBox,
          transactionsBox: transactionsBox));
}
