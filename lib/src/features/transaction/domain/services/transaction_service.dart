import 'dart:isolate';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_transactions.dart';

class TransactionService {
  final TransactionDatasource _transactionDatasource;

  TransactionService(
      {required TransactionDatasource transactionDatasource,
      required FinancialSummaryDatasource financialSummaryDatasource})
      : _transactionDatasource = transactionDatasource;

  Future<Map<String, List<TransactionModel>>?> getTransactionsMonth(
      {required int month, required int year}) async {
    final yearlyTransactionsKey =
        HiveHelper.generateYearlyTransactionKey(year: year);

    final yearlyTransactions = await _transactionDatasource
        .getYearlyTransactions(key: yearlyTransactionsKey);

    final monthTransactions = yearlyTransactions?.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions == null || monthTransactions.isEmpty) {
      return null;
    }

    return monthTransactions.first.transactions;
  }

  Future<TransactionsSummary> getMonthSummary(
      {required Map<String, List<TransactionModel>>? transactionsMonth,
      required FinancialSummaryModel? monthSummary}) async {
    if (transactionsMonth == null || monthSummary == null) {
      return TransactionsSummary.initial();
    }

    final transactionsSummary = await Isolate.run(() {
      final transactionsData = transactionsMonth.entries.map((entry) {
        final date = DatetimeHelper.parse(input: entry.key);
        final transactions = entry.value.map((t) => t.toEntity()).toList();
        return TransactionsData(transactions: transactions, date: date);
      }).toList();

      return TransactionsSummary(
        transactionsData: transactionsData,
        income: monthSummary.income,
        total: monthSummary.netWorth,
        expense: monthSummary.expense,
      );
    });

    return transactionsSummary;
  }

  Future<TransactionsSummary> getSummaryByDate({required DateTime date}) async {
    final yearlyKey = HiveHelper.generateYearlyTransactionKey(year: date.year);

    final yearlyTransactionModel =
        await _transactionDatasource.getYearlyTransactions(key: yearlyKey);

    if (yearlyTransactionModel == null) {
      return TransactionsSummary.initial();
    }

    final month = date.month;
    final transactionDayKey = HiveHelper.generateTransactionDayKey(date: date);

    final monthTransaction = (yearlyTransactionModel.months).firstWhere(
      (m) => m.month == month,
      orElse: () => MonthlyTransactionsModel.initial(month: month),
    );

    final models = monthTransaction.transactions[transactionDayKey] ?? [];
    final rawModels = models.map((model) => model.toMap()).toList();
    final grouped = {date: rawModels};

    int income = 0;
    int expense = 0;

    final transactionData = await Isolate.run(() {
      final transactionsModelsRaw = (grouped[date] ?? []).toList();

      final transactions = transactionsModelsRaw.map((entry) {
        final transactionModel = TransactionModel.fromMap(entry);
        return transactionModel.toEntity();
      }).toList();

      return TransactionsData(transactions: transactions, date: date);
    });

    for (final transaction in transactionData.transactions) {
      if (transaction.type == TransactionTypEnum.income) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    return TransactionsSummary(
        transactionsData: [transactionData],
        income: income,
        total: income - expense,
        expense: expense);
  }

  Future<List<AccountSummaryItem>> getAccountSummaryItems() async {
    final transactionsSourceModels =
        await _transactionDatasource.getTransactionSources();

    final modelsRaw =
        transactionsSourceModels.map((model) => model.toJson()).toList();

    final result = await Isolate.run(() {
      final data = modelsRaw.map((source) {
        final name = source["name"] as String;
        final icon = source["icon"] as String;

        final transactionSource = TransactionSource(name: name, icon: icon);
        const amount = 0;

        return AccountSummaryItem(
            transactionSource: transactionSource, amount: amount);
      }).toList();

      return data;
    });

    final defaultTransactionSource = TransactionsConstants
        .kDefaultTransactionSources
        .map((transactionSource) =>
            AccountSummaryItem(transactionSource: transactionSource, amount: 0))
        .toList();

    result.addAll(defaultTransactionSource);

    return result;
  }

  Future<void> saveYearlyTransaction({required Transaction transaction}) async {
    final date = transaction.transactionDate;
    final year = date.year;

    final yearlyTransactionKey =
        HiveHelper.generateYearlyTransactionKey(year: year);

    YearlyTransactionsModel currentYearlyTransactionsModel =
        await _transactionDatasource.getYearlyTransactions(
                key: yearlyTransactionKey) ??
            YearlyTransactionsModel.initial(year: year);

    final updatedYearlyTransactions = _updateYearlyTransaction(
        yearlyTransactions: currentYearlyTransactionsModel.toEntity(),
        transaction: transaction);

    currentYearlyTransactionsModel =
        YearlyTransactionsModel.fromEntity(updatedYearlyTransactions);

    await _transactionDatasource.save(
        model: currentYearlyTransactionsModel, key: yearlyTransactionKey);
  }

  Future<void> updateTransaction({required Transaction transaction}) async {
    final date = transaction.transactionDate;
    final year = date.year;
    final month = date.month;

    final yearlyTransactionKey =
        HiveHelper.generateYearlyTransactionKey(year: year);

    final dayKey = HiveHelper.generateTransactionDayKey(date: date);

    final transactions = await getTransactionsByDate(date: date);

    final existsTransaction = transactions.indexWhere((currentTransaction) {
      final currentId = currentTransaction.id;
      if (currentId != null &&
          transaction.id != null &&
          currentId == transaction.id) {
        return true;
      }

      return false;
    });

    final yearlyTransactions = await _transactionDatasource
        .getYearlyTransactions(key: yearlyTransactionKey);

    if (yearlyTransactions == null) {
      return;
    }

    final transactionModel = TransactionModel.fromEntity(transaction);
    transactions[existsTransaction] = transactionModel;

    final monthTransactionsIndex =
        yearlyTransactions.months.indexWhere((model) => model.month == month);

    final monthlyTransactions =
        yearlyTransactions.months[monthTransactionsIndex];

    final updatedMonthTransactions =
        yearlyTransactions.months[monthTransactionsIndex].copyWith(
      transactions: {
        ...monthlyTransactions.transactions,
        dayKey: transactions,
      },
    );

    yearlyTransactions.months[monthTransactionsIndex] =
        updatedMonthTransactions;

    await _transactionDatasource.save(
        model: yearlyTransactions, key: yearlyTransactionKey);
  }

  YearlyTransactions _updateYearlyTransaction(
      {required YearlyTransactions? yearlyTransactions,
      required Transaction transaction}) {
    final date = transaction.transactionDate;
    final month = date.month;

    yearlyTransactions =
        yearlyTransactions ?? YearlyTransactions.initial(year: date.year);

    final dayKey = HiveHelper.generateTransactionDayKey(date: date);
    final monthIndex =
        yearlyTransactions.months.indexWhere((m) => m.month == month);

    MonthlyTransactions monthlyTransactions;

    if (monthIndex != -1) {
      monthlyTransactions = yearlyTransactions.months[monthIndex];
    } else {
      monthlyTransactions = MonthlyTransactions.initial(month: month);
      yearlyTransactions.months.add(monthlyTransactions);
    }

    final transactionsByDay = List<Transaction>.from(
      monthlyTransactions.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(transaction);

    monthlyTransactions = monthlyTransactions.copyWith(
      transactions: {
        ...monthlyTransactions.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      yearlyTransactions.months[monthIndex] = monthlyTransactions;
    } else {
      final lastIndex = yearlyTransactions.months.length - 1;
      yearlyTransactions.months[lastIndex] = monthlyTransactions;
    }

    return yearlyTransactions;
  }

  Future<List<TransactionModel>> getTransactionsByDate(
      {required DateTime date}) async {
    final month = date.month;
    final year = date.year;

    final monthTransactions =
        await getTransactionsMonth(month: month, year: year);

    if (monthTransactions == null || monthTransactions.isEmpty) {
      return [];
    }

    final transactions = monthTransactions.values
        .expand((list) => list)
        /*.map((model) => model.toEntity())*/
        .toList();

    return transactions;
  }
}
