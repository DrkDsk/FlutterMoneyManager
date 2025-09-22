import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';

abstract interface class TransactionDatasource {
  Future<bool> save(
      {required YearlyTransactionsModel model, required String key});

  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<YearlyTransactionsModel> getYearlyTransactionsModel(
      {required int year});

  Future<List<TransactionModel>> getTransactionsByMonth(
      {required int year, required int month});

  Future<void> saveTransaction({required TransactionModel model});

  Future<List<TransactionModel>> getAllTransactions();
}
