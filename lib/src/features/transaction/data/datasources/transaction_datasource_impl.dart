import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_month_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/balance_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionHiveModel> _transactionBox;
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<GlobalBalanceHiveModel> _globalBalanceBox;
  final Box<BalanceYearHiveModel> _yearBalanceBox;
  final Box<TransactionsYearHiveModel> _transactionsYearBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionHiveModel> transactionBox,
      required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<GlobalBalanceHiveModel> globalBalanceBox,
      required Box<BalanceYearHiveModel> yearBalanceBox,
      required Box<TransactionsYearHiveModel> transactionsYearBox})
      : _transactionBox = transactionBox,
        _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceBox,
        _transactionsYearBox = transactionsYearBox,
        _yearBalanceBox = yearBalanceBox;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    final year = transaction.transactionDate.year;
    final month = transaction.transactionDate.month;
    final transactionKey = "$year";

    final transactionsYear = _transactionsYearBox.get(transactionKey) ??
        TransactionsYearHiveModel(year: year, months: []);

    final exitsMonthRegisteredIndex = transactionsYear.months
        .indexWhere((currentMonth) => currentMonth.month == month);

    if (exitsMonthRegisteredIndex != -1) {
      final monthTransactions =
          transactionsYear.months[exitsMonthRegisteredIndex];
      monthTransactions.transactions.add(hiveModel);
    } else {
      final TransactionsMonthHiveModel monthTransactionHiveModel =
          TransactionsMonthHiveModel(month: month, transactions: []);

      monthTransactionHiveModel.transactions.add(hiveModel);
      transactionsYear.months.add(monthTransactionHiveModel);
    }

    await _transactionsYearBox.put(transactionKey, transactionsYear);

    _updateGlobalBalanceRegister(transaction: transaction);

    return true;
  }

  Future<void> _updateGlobalBalanceRegister({
    required Transaction transaction,
  }) async {
    final isIncome = transaction.type == TransactionTypEnum.income;
    final source = transaction.sourceType ?? "Unknown";
    final transactionDate = transaction.transactionDate;
    final monthIndex = transactionDate.month;
    final year = transactionDate.year;

    BalanceYearHiveModel yearCurrentModel =
        _yearBalanceBox.get(year.toString()) ??
            BalanceYearHiveModel(year: year, months: []);

    final listMonthsSaved = yearCurrentModel.months
        .where((model) => model.month == monthIndex)
        .toList();

    final baseBalance = listMonthsSaved.isNotEmpty
        ? listMonthsSaved.first.balance
        : GlobalBalanceHiveModel(
            income: 0,
            expense: 0,
            total: 0,
            asset: 0,
            debt: 0,
            balancesBySource: {},
          );

    final amount = transaction.amount;

    final newIncome = baseBalance.income + (isIncome ? amount : 0);
    final newExpense = baseBalance.expense + (!isIncome ? amount : 0);

    final newTotal = baseBalance.total + (isIncome ? amount : -amount);

    final Map<String, int> updatedSources =
        Map.from(baseBalance.balancesBySource);

    final currentSourceBalance = updatedSources[source] ?? 0;
    final newSourceBalance =
        currentSourceBalance + (isIncome ? amount : -amount);

    updatedSources[source] = newSourceBalance;

    final newAsset = updatedSources.entries
        .where((entry) => kPositiveTransactionSources.contains(entry.key))
        .fold<int>(
            0, (sum, entry) => sum + (entry.value < 0 ? 0 : entry.value));

    final newDebt = updatedSources.entries
        .where((entry) => kNegativeTransactionSources.contains(entry.key))
        .fold<int>(
            0,
            (sum, entry) =>
                sum + (entry.value < 0 ? -entry.value : entry.value));

    final updatedBalance = baseBalance.copyWith(
      income: newIncome,
      expense: newExpense,
      total: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );
    final monthBalanceHiveModel =
        MonthBalanceHiveModel(month: monthIndex, balance: updatedBalance);

    final index =
        yearCurrentModel.months.indexWhere((m) => m.month == monthIndex);

    if (index != -1) {
      yearCurrentModel.months[index] = monthBalanceHiveModel;
    } else {
      yearCurrentModel.months.add(monthBalanceHiveModel);
    }

    await _yearBalanceBox.put(year.toString(), yearCurrentModel);
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModels(
      {required int month, required int year}) async {
    final transactionYearKey = "$year";
    final yearTransactions = _transactionsYearBox.get(transactionYearKey);

    if (yearTransactions == null) {
      return [];
    }

    final monthTransactions = yearTransactions.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions.isEmpty) {
      return [];
    }

    return monthTransactions.first.transactions;
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

  @override
  Future<GlobalBalanceHiveModel?> getTransactionGlobalBalance() async {
    final globalTransactionBalance = _globalBalanceBox.get("summary");

    return globalTransactionBalance;
  }

  @override
  Future<BalanceYearHiveModel?> getTransactionsByYear({int? year}) async {
    final selectedYear = year ?? DateTime.now().year;

    final yearTransactions = _yearBalanceBox.get(selectedYear.toString());

    return yearTransactions;
  }
}
