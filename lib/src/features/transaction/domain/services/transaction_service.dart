import 'dart:isolate';

import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_transactions.dart';

class TransactionService {
  final TransactionDatasource _transactionDatasource;
  final FinancialSummaryDatasource _financialSummaryDatasource;

  TransactionService(
      {required TransactionDatasource transactionDatasource,
      required FinancialSummaryDatasource financialSummaryDatasource})
      : _transactionDatasource = transactionDatasource,
        _financialSummaryDatasource = financialSummaryDatasource;

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

  Future<FinancialSummaryModel?> getBalanceByMonth(
      {required String key, required int month}) async {
    final yearlyBalances =
        await _financialSummaryDatasource.getBalancesByYear(key: key);

    if (yearlyBalances == null) {
      return null;
    }

    final balances = yearlyBalances.months
        .where((monthBalance) => monthBalance.month == month)
        .toList();

    if (balances.isEmpty) {
      return null;
    }

    return balances.first.summary;
  }

  Future<TransactionsSummary> getMonthSummary(
      {required Map<String, List<TransactionModel>>? monthTransactions,
      required FinancialSummaryModel? monthBalance}) async {
    if (monthTransactions == null || monthBalance == null) {
      return TransactionsSummary.initial();
    }

    final transactionsSummary = await Isolate.run(() {
      final transactionsData = monthTransactions.entries.map((entry) {
        final date = DatetimeHelper.parse(input: entry.key);
        final transactions = entry.value.map((t) => t.toEntity()).toList();
        return TransactionsData(transactions: transactions, date: date);
      }).toList();

      return TransactionsSummary(
        transactionsData: transactionsData,
        income: monthBalance.income,
        total: monthBalance.netWorth,
        expense: monthBalance.expense,
      );
    });

    return transactionsSummary;
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

    MonthlyTransactions monthlyTransactionsDTO;

    if (monthIndex != -1) {
      monthlyTransactionsDTO = yearlyTransactions.months[monthIndex];
    } else {
      monthlyTransactionsDTO = MonthlyTransactions.initial(month: month);
      yearlyTransactions.months.add(monthlyTransactionsDTO);
    }

    final transactionsByDay = List<Transaction>.from(
      monthlyTransactionsDTO.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(transaction);

    monthlyTransactionsDTO = monthlyTransactionsDTO.copyWith(
      transactions: {
        ...monthlyTransactionsDTO.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      yearlyTransactions.months[monthIndex] = monthlyTransactionsDTO;
    } else {
      final lastIndex = yearlyTransactions.months.length - 1;
      yearlyTransactions.months[lastIndex] = monthlyTransactionsDTO;
    }

    return yearlyTransactions;
  }
}
