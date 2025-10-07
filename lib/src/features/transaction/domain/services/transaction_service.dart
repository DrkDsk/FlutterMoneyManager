import 'dart:isolate';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:uuid/uuid.dart';

class TransactionService {
  final TransactionDatasource _transactionDatasource;

  TransactionService({required TransactionDatasource transactionDatasource})
      : _transactionDatasource = transactionDatasource;

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

  Future<List<TransactionModel>> getTransactionsMonth(
      {required int month, required int year}) async {
    final transactions = await _transactionDatasource.getAllTransactions();

    final filtered = await Isolate.run(() {
      return transactions
          .where((t) =>
              t.transactionDate.year == year &&
              t.transactionDate.month == month)
          .toList();
    });

    return filtered;
  }

  Future<List<TransactionModel>> getTransactionsByDate(
      {required DateTime date}) async {
    final year = date.year;
    final month = date.month;
    final day = date.day;

    final transactions = await _transactionDatasource.getAllTransactions();

    final filtered = await Isolate.run(() {
      return transactions
          .where((t) =>
              t.transactionDate.year == year &&
              t.transactionDate.month == month &&
              t.transactionDate.day == day)
          .toList();
    });

    return filtered;
  }

  Future<TransactionsSummary> getSummaryWithTransactions(
      {required List<TransactionModel> transactions}) async {
    int income = 0;
    int expense = 0;

    final grouped = _groupTransactionsByDate(transactions: transactions);

    final transactionsSummary = await Isolate.run(() {
      final transactionsData = grouped.entries.map((entry) {
        final date = DatetimeHelper.parse(input: entry.key);
        final transactions = entry.value.map((t) => t.toEntity()).toList();
        return TransactionsData(transactions: transactions, date: date);
      }).toList();

      for (final transaction in transactions) {
        if (transaction.type == TransactionTypEnum.income) {
          income += transaction.amount;
        } else {
          expense += transaction.amount;
        }
      }

      final summary = MonthlySummary(
          income: income, expense: expense, total: income - expense);

      return TransactionsSummary(
          transactionsData: transactionsData, summary: summary);
    });

    return transactionsSummary;
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

      final defaultTransactionSource = TransactionsConstants
          .kDefaultTransactionSources
          .map((transactionSource) => AccountSummaryItem(
              transactionSource: transactionSource, amount: 0))
          .toList();

      data.addAll(defaultTransactionSource);

      return data;
    });

    return result;
  }

  Future<void> saveTransaction(
      {required TransactionModel transactionModel}) async {
    if (transactionModel.id == null) {
      transactionModel = transactionModel.copyWith(id: const Uuid().v4());
    }

    await _transactionDatasource.save(model: transactionModel);
  }

  Future<void> delete({required String id}) async {
    await _transactionDatasource.delete(id: id);
  }
}
