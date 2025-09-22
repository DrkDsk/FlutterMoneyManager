import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

abstract interface class TransactionDatasource {
  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<List<TransactionModel>> getAllTransactions();

  Future<List<TransactionModel>> getTransactionsByMonth(
      {required int year, required int month});

  Future<void> save({required TransactionModel model});
}
