import 'dart:isolate';

import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/services/financial_calculator_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
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
  Future<bool> saveTransaction(Transaction transaction) async {
    try {
      final hiveModel = TransactionHiveModel.fromEntity(transaction);

      final date = transaction.transactionDate;
      final year = date.year;
      final month = date.month;

      final transactionKey = HiveHelper.generateTransactionYearKey(date: date);
      final dayKey = HiveHelper.generateTransactionDayKey(date: date);

      final transactionsYear = _transactionsYearBox.get(transactionKey) ??
          YearlyTransactionsHiveModel.initial(year: year);

      final monthIndex =
          transactionsYear.months.indexWhere((m) => m.month == month);

      MonthlyTransactionsHiveModel monthModel;

      if (monthIndex != -1) {
        monthModel = transactionsYear.months[monthIndex];
      } else {
        monthModel = MonthlyTransactionsHiveModel.initial(month: month);
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
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  Future<void> _updateGlobalBalanceRegister({
    required Transaction transaction,
  }) async {
    final date = transaction.transactionDate;
    final year = date.year;
    final month = date.month;

    YearlyFinancialSummaryHiveModel yearCurrentModel =
        _yearBalanceBox.get(year.toString()) ??
            YearlyFinancialSummaryHiveModel(year: year, months: []);

    final yearModelAsMap = yearCurrentModel.toEntityMap();

    final monthIndexOfCurrentTransaction =
        yearCurrentModel.months.indexWhere((m) => m.month == month);

    final monthBalance = await Isolate.run(() {
      final baseBalance = yearModelAsMap[month] ??
          FinancialSummaryHiveModel.initial().toEntity();

      final calculator = FinancialCalculatorService.fromTransaction(
          transaction: transaction,
          balancesBySource: baseBalance.balancesBySource);

      final updatedBalance = calculator.calculateUpdatedSummary(baseBalance);

      return MonthlyFinancialSummaryHiveModel(
        month: month,
        summary: FinancialSummaryHiveModel.fromEntity(updatedBalance),
      );
    });

    if (monthIndexOfCurrentTransaction != -1) {
      yearCurrentModel.months[monthIndexOfCurrentTransaction] = monthBalance;
    } else {
      yearCurrentModel.months.add(monthBalance);
    }

    _updateGlobalSummary(transaction: transaction);

    await _yearBalanceBox.put(year.toString(), yearCurrentModel);
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
  Future<FinancialSummaryHiveModel> getGlobalFinancialSummary() async {
    final globalTransactionBalance =
        _globalBalanceBox.get(HiveConstants.globalSummaryKey);

    return globalTransactionBalance ?? FinancialSummaryHiveModel.initial();
  }

  @override
  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear(
      {int? year}) async {
    final balanceYearKey = (year ?? DateTime.now().year).toString();

    return _yearBalanceBox.get(balanceYearKey);
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

  Future<void> _updateGlobalSummary({required Transaction transaction}) async {
    final globalSummaryEntity =
        _globalBalanceBox.get(HiveConstants.globalSummaryKey) ??
            FinancialSummaryHiveModel.initial();

    final updatedGlobalSummary = FinancialCalculatorService.fromTransaction(
      transaction: transaction,
      balancesBySource: globalSummaryEntity.balancesBySource,
    ).calculateUpdatedSummary(globalSummaryEntity.toEntity());

    await _globalBalanceBox.put(
      HiveConstants.globalSummaryKey,
      FinancialSummaryHiveModel.fromEntity(updatedGlobalSummary),
    );
  }
}
