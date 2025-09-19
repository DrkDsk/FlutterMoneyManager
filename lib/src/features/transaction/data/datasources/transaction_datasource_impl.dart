import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<YearlyTransactionsHiveModel> _transactionsYearBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<YearlyTransactionsHiveModel> transactionsYearBox})
      : _transactionSourceBox = transactionSourceBox,
        _transactionsYearBox = transactionsYearBox;

  @override
  Future<bool> save(
      {required YearlyTransactionsModel model, required String key}) async {
    try {
      final hiveModel = YearlyTransactionsHiveModel.fromModel(model);
      await _transactionsYearBox.put(key, hiveModel);

      return true;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<YearlyTransactionsModel?> getYearlyTransactions(
      {required String key}) async {
    final hiveModel = _transactionsYearBox.get(key);

    if (hiveModel == null) {
      return null;
    }

    return YearlyTransactionsModel.fromHive(hiveModel);
  }
}
