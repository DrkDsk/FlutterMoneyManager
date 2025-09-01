import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionDatasource {
  Future<bool> saveTransaction(Transaction transaction);
  Future<List<TransactionHiveModel>> getTransactionsModels(
      {required int monthIndex});
}
