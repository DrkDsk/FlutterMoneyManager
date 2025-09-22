import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<YearlyTransactionsHiveModel> _transactionsYearBox;
  final Box<TransactionHiveModel> _transactionsBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<YearlyTransactionsHiveModel> transactionsYearBox,
      required Box<TransactionHiveModel> transactionsBox})
      : _transactionSourceBox = transactionSourceBox,
        _transactionsBox = transactionsBox,
        _transactionsYearBox = transactionsYearBox;

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByMonth(
      {required int year, required int month}) async {
    final monthly = await _getMonthlyTransactions(year: year, month: month);

    if (monthly.isEmpty) {
      return [];
    }

    return monthly.first.transactions.values
        .expand((txList) => txList)
        .toList();
  }

  Future<List<MonthlyTransactionsModel>> _getMonthlyTransactions(
      {required int year, required int month}) async {
    final yearlyKey = HiveHelper.generateYearlyTransactionKey(year: year);
    final yearly = _transactionsYearBox.get(yearlyKey);
    if (yearly == null) {
      return [];
    }

    final monthly = yearly.months
        .where(
          (m) => m.month == month,
        )
        .toList();

    if (monthly.isEmpty) {
      return [];
    }

    return monthly
        .map((model) => MonthlyTransactionsModel.fromHive(model))
        .toList();
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
}
