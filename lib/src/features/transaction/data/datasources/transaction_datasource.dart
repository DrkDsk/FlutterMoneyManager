import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

abstract interface class TransactionDatasource {
  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<List<TransactionModel>> getAllTransactions();

  Future<void> save({required TransactionModel model});

  Future<void> delete({required String id});
}
