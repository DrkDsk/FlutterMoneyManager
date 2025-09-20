import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
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
  Future<List<TransactionModel>> getTransactionsByMonth(
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

    final transactions =
        monthly.first.transactions.values.expand((txList) => txList).toList();

    return transactions
        .map((hiveModel) => TransactionModel.fromHive(hiveModel))
        .toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDate(
      {required DateTime date}) async {
    final year = date.year;
    final month = date.month;
    final yearlyKey = HiveHelper.generateYearlyTransactionKey(year: year);
    final dayKey = HiveHelper.generateTransactionDayKey(date: date);
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

    final transactions = monthly.first.transactions[dayKey] ?? [];

    return transactions
        .map((model) => TransactionModel.fromHive(model))
        .toList();
  }

  @override
  Future<YearlyTransactionsModel> getYearlyTransactionsModel(
      {required int year}) async {
    final key = HiveHelper.generateYearlyTransactionKey(year: year);
    final hive = _transactionsYearBox.get(key);

    if (hive == null) {
      return YearlyTransactionsModel.initial(year: year);
    }

    return YearlyTransactionsModel.fromHive(hive);
  }
}
