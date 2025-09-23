import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<TransactionHiveModel> _transactionsBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<TransactionHiveModel> transactionsBox})
      : _transactionSourceBox = transactionSourceBox,
        _transactionsBox = transactionsBox;

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<void> save({required TransactionModel model}) async {
    final hive = TransactionHiveModel.fromModel(model);

    await _transactionsBox.put(model.id, hive);
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final transactions = _transactionsBox.values.toList();

    return transactions.map((hive) => TransactionModel.fromHive(hive)).toList();
  }

  @override
  Future<void> delete({required String id}) async {
    await _transactionsBox.delete(id);
  }
}
