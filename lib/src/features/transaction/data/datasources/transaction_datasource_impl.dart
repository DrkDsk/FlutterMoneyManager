import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<FinancialSummaryHiveModel> _globalBalanceBox;
  final Box<YearlyFinancialSummaryHiveModel> _yearBalanceBox;
  final Box<YearlyTransactionsHiveModel> _transactionsYearBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<FinancialSummaryHiveModel> globalBalanceBox,
      required Box<YearlyFinancialSummaryHiveModel> yearBalanceBox,
      required Box<YearlyTransactionsHiveModel> transactionsYearBox})
      : _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceBox,
        _transactionsYearBox = transactionsYearBox,
        _yearBalanceBox = yearBalanceBox;

  @override
  Future<bool> save(
      {required YearlyTransactionsHiveModel model, required String key}) async {
    try {
      await _transactionsYearBox.put(key, model);

      /* _updateGlobalBalanceRegister(transaction: transaction);*/

      return true;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<Map<String, List<TransactionHiveModel>>> getTransactionsModelsMonth(
      {required int month, required int year}) async {
    final transactionYearKey = "$year";
    final yearTransactions = _transactionsYearBox.get(transactionYearKey);

    if (yearTransactions == null) {
      return const {};
    }

    final monthTransactions = yearTransactions.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions.isEmpty) {
      return const {};
    }

    return monthTransactions.first.transactions;
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModelsByDate(
      {required DateTime date}) async {
    final month = date.month;

    final transactionYearKey =
        HiveHelper.generateTransactionYearKey(date: date);
    final transactionDayKey = HiveHelper.generateTransactionDayKey(date: date);

    final yearTransactions = _transactionsYearBox.get(transactionYearKey);

    if (yearTransactions == null) {
      return const [];
    }

    final monthTransactions = yearTransactions.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions.isEmpty) {
      return const [];
    }

    return monthTransactions.first.transactions[transactionDayKey] ?? [];
  }

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<FinancialSummaryHiveModel?> getGlobalFinancialSummary(
      {required String key}) async {
    final globalTransactionBalance = _globalBalanceBox.get(key);

    return globalTransactionBalance;
  }

  @override
  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear(
      {required String key}) async {
    return _yearBalanceBox.get(key);
  }

  @override
  Future<FinancialSummaryHiveModel> getBalancesMonth(
      {int? year, int? month}) async {
    final defaultValue = DateTime.now();
    final selectedYear = year ?? defaultValue.year;
    final selectedMonth = month ?? defaultValue.month;

    final yearBalances = _yearBalanceBox.get(selectedYear.toString()) ??
        YearlyFinancialSummaryHiveModel.initial(year: selectedYear);

    final balances = yearBalances.months
        .where((monthBalance) => monthBalance.month == selectedMonth)
        .toList();

    if (balances.isEmpty) {
      return FinancialSummaryHiveModel.initial();
    }

    return balances.first.summary;
  }

  @override
  Future<YearlyTransactionsHiveModel?> getYearlyTransactionsHiveModel(
      {required String key}) async {
    return _transactionsYearBox.get(key);
  }

  @override
  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryHiveModel model,
      required String key}) async {
    await _yearBalanceBox.put(key, model);

    return true;
  }

  @override
  Future<bool> saveFinancialSummary(
      {required FinancialSummaryHiveModel model, required String key}) async {
    await _globalBalanceBox.put(
      key,
      model,
    );

    return true;
  }
}
