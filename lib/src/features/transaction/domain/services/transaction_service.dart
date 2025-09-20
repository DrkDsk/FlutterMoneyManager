import 'dart:isolate';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  final TransactionDatasource _transactionDatasource;

  TransactionService({required TransactionDatasource transactionDatasource})
      : _transactionDatasource = transactionDatasource;

  Future<List<TransactionModel>> getTransactionsMonth(
      {required int month, required int year}) async {
    final monthTransactions = await _transactionDatasource
        .getTransactionsByMonth(year: year, month: month);

    return monthTransactions;
  }

  Map<String, List<TransactionModel>> _groupTransactionsByDate(
      {required List<TransactionModel> transactions}) {
    final Map<String, List<TransactionModel>> transactionsMonthEntries = {};

    for (final tx in transactions) {
      final date = tx.transactionDate;

      final key = HiveHelper.generateTransactionDayKey(date: date);

      transactionsMonthEntries.putIfAbsent(key, () => []);
      transactionsMonthEntries[key]!.add(tx);
    }

    return transactionsMonthEntries;
  }

  Future<TransactionsSummary> getMonthlyTransactionSummary(
      {required List<TransactionModel> transactionsMonth,
      required FinancialSummaryModel? monthSummary}) async {
    if (monthSummary == null) {
      return TransactionsSummary.initial();
    }

    final grouped = _groupTransactionsByDate(transactions: transactionsMonth);

    final transactionsSummary = await Isolate.run(() {
      final transactionsData = grouped.entries.map((entry) {
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
    final transactionsModels =
        await _transactionDatasource.getTransactionsByDate(date: date);

    int income = 0;
    int expense = 0;

    final transactions =
        transactionsModels.map((model) => model.toEntity()).toList();

    final transactionData =
        TransactionsData(transactions: transactions, date: date);

    for (final transaction in transactionsModels) {
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

  Future<void> saveYearlyTransaction(
      {required TransactionModel transactionModel}) async {
    final yearlyTransactionKey = HiveHelper.generateYearlyTransactionKey(
        year: transactionModel.transactionDate.year);

    final updatedYearly =
        await _updateYearlyTransaction(transactionModel: transactionModel);

    await _transactionDatasource.save(
        model: updatedYearly, key: yearlyTransactionKey);
  }

  Future<YearlyTransactionsModel> _updateYearlyTransaction(
      {required TransactionModel transactionModel}) async {
    final date = transactionModel.transactionDate;
    final year = date.year;
    final month = date.month;
    final dayKey = HiveHelper.generateTransactionDayKey(date: date);

    final yearly =
        await _transactionDatasource.getYearlyTransactionsModel(year: year);

    var months = List<MonthlyTransactionsModel>.from(yearly.months);
    var monthlyIndex = months.indexWhere((m) => m.month == month);

    MonthlyTransactionsModel monthly;
    if (monthlyIndex == -1) {
      monthly = MonthlyTransactionsModel(month: month, transactions: {});
      months.add(monthly);
      monthlyIndex = months.length - 1;
    } else {
      monthly = months[monthlyIndex];
    }

    final transactionsMap =
        Map<String, List<TransactionModel>>.from(monthly.transactions);
    final dailyTxs = transactionsMap.putIfAbsent(dayKey, () => []);

    if (transactionModel.id == null) {
      final newTx = transactionModel.copyWith(id: const Uuid().v4());
      dailyTxs.add(newTx);
    } else {
      final index = dailyTxs.indexWhere((t) => t.id == transactionModel.id);
      if (index != -1) {
        dailyTxs[index] = transactionModel;
      } else {
        dailyTxs.add(transactionModel);
      }
    }

    final updatedMonthly = monthly.copyWith(transactions: transactionsMap);
    months[monthlyIndex] = updatedMonthly;

    return yearly.copyWith(months: months);
  }
}
