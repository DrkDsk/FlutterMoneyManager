import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionHiveModel> _transactionBox;
  final Box<TransactionSourceHiveModel> _transactionSourceBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionHiveModel> transactionBox,
      required Box<TransactionSourceHiveModel> transactionSourceBox})
      : _transactionBox = transactionBox,
        _transactionSourceBox = transactionSourceBox;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    await _transactionBox.add(hiveModel);
    return true;
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModels(
      {required int monthIndex}) async {
    final values = _transactionBox.values.toList();

    final filtered = values.where((transaction) {
      return transaction.transactionDate.month == monthIndex;
    }).toList();

    return filtered;
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModelsByDate(
      {required DateTime date}) async {
    final values = _transactionBox.values.toList();

    final filtered = values.where((transaction) {
      final tDate = transaction.transactionDate;
      return tDate.year == date.year &&
          tDate.month == date.month &&
          tDate.day == date.day;
    }).toList();

    return filtered;
  }

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }
}
