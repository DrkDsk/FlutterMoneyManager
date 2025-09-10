import 'dart:isolate';

import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_month_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/balance_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/services/balance_calculator_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<GlobalBalanceHiveModel> _globalBalanceBox;
  final Box<BalanceYearHiveModel> _yearBalanceBox;
  final Box<TransactionsYearHiveModel> _transactionsYearBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<GlobalBalanceHiveModel> globalBalanceBox,
      required Box<BalanceYearHiveModel> yearBalanceBox,
      required Box<TransactionsYearHiveModel> transactionsYearBox})
      : _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceBox,
        _transactionsYearBox = transactionsYearBox,
        _yearBalanceBox = yearBalanceBox;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    final date = transaction.transactionDate;
    final year = date.year;
    final month = date.month;

    final transactionKey = HiveHelper.generateTransactionYearKey(date: date);
    final dayKey = HiveHelper.generateTransactionDayKey(date: date);

    final transactionsYear = _transactionsYearBox.get(transactionKey) ??
        TransactionsYearHiveModel(year: year, months: []);

    final monthIndex =
        transactionsYear.months.indexWhere((m) => m.month == month);

    TransactionsMonthHiveModel monthModel;

    if (monthIndex != -1) {
      monthModel = transactionsYear.months[monthIndex];
    } else {
      monthModel = TransactionsMonthHiveModel.initial(month: month);
      transactionsYear.months.add(monthModel);
    }

    final transactionsByDay = List<TransactionHiveModel>.from(
      monthModel.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(hiveModel);

    monthModel = monthModel.copyWith(
      transactions: {
        ...monthModel.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      transactionsYear.months[monthIndex] = monthModel;
    } else {
      final lastIndex = transactionsYear.months.length - 1;
      transactionsYear.months[lastIndex] = monthModel;
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
    final date = transaction.transactionDate;
    final year = date.year;
    final month = date.month;

    BalanceYearHiveModel yearCurrentModel =
        _yearBalanceBox.get(year.toString()) ??
            BalanceYearHiveModel(year: year, months: []);

    final yearModelAsMap = yearCurrentModel.toEntityMap();

    final monthIndexOfCurrentTransaction =
        yearCurrentModel.months.indexWhere((m) => m.month == month);

    final monthBalance = await Isolate.run(() {
      final baseBalance =
          yearModelAsMap[month] ?? GlobalBalanceHiveModel.initial().toEntity();

      final calculator = BalanceCalculatorService(
        isIncome: isIncome,
        source: source,
        amount: transaction.amount,
        balancesBySource: baseBalance.balancesBySource,
      );

      final updatedBalance = calculator.calculateUpdatedBalance(baseBalance);

      return MonthBalanceHiveModel(
        month: month,
        balance: GlobalBalanceHiveModel.fromEntity(updatedBalance),
      );
    });

    if (monthIndexOfCurrentTransaction != -1) {
      yearCurrentModel.months[monthIndexOfCurrentTransaction] = monthBalance;
    } else {
      yearCurrentModel.months.add(monthBalance);
    }

    await _yearBalanceBox.put(year.toString(), yearCurrentModel);
  }

  @override
  Future<TransactionsMonthHiveModel> getTransactionsModelsMonth(
      {required int month, required int year}) async {
    final transactionYearKey = "$year";
    final yearTransactions = _transactionsYearBox.get(transactionYearKey);

    final emptyTransactionsMonthModel =
        TransactionsMonthHiveModel(month: month, transactions: {});

    if (yearTransactions == null) {
      return emptyTransactionsMonthModel;
    }

    final monthTransactions = yearTransactions.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions.isEmpty) {
      return emptyTransactionsMonthModel;
    }

    return monthTransactions.first;
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
  Future<GlobalBalanceHiveModel?> getGlobalBalance() async {
    final globalTransactionBalance = _globalBalanceBox.get("summary");

    return globalTransactionBalance;
  }

  @override
  Future<BalanceYearHiveModel?> getBalancesByYear({int? year}) async {
    final selectedYear = year ?? DateTime.now().year;

    final yearTransactions = _yearBalanceBox.get(selectedYear.toString());

    return yearTransactions;
  }

  @override
  Future<GlobalBalanceHiveModel> getBalancesMonth(
      {int? year, int? month}) async {
    final defaultValue = DateTime.now();
    final selectedYear = year ?? defaultValue.year;
    final selectedMonth = month ?? defaultValue.month;

    final yearBalances = _yearBalanceBox.get(selectedYear.toString()) ??
        BalanceYearHiveModel.initial(year: selectedYear);

    final balances = yearBalances.months
        .where((monthBalance) => monthBalance.month == selectedMonth)
        .toList();

    if (balances.isEmpty) {
      return GlobalBalanceHiveModel.initial();
    }

    return balances.first.balance;
  }
}
