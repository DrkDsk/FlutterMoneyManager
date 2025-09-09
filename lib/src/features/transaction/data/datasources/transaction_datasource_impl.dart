import 'dart:isolate';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/year_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/services/balance_calculator_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionHiveModel> _transactionBox;
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<GlobalBalanceHiveModel> _globalBalanceBox;
  final Box<YearBalanceHiveModel> _yearBalanceBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionHiveModel> transactionBox,
      required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<GlobalBalanceHiveModel> globalBalanceBox,
      required Box<YearBalanceHiveModel> yearBalanceBox})
      : _transactionBox = transactionBox,
        _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceBox,
        _yearBalanceBox = yearBalanceBox;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    await _transactionBox.add(hiveModel);

    _updateGlobalBalanceRegister(transaction: transaction);

    return true;
  }

  Future<void> _updateGlobalBalanceRegister({
    required Transaction transaction,
  }) async {
    final isIncome = transaction.type == kIncomeType;
    final source = transaction.sourceType ?? "Unknown";
    final year = transaction.transactionDate.year;
    final month = transaction.transactionDate.month;

    YearBalanceHiveModel yearCurrentModel =
        _yearBalanceBox.get(year.toString()) ??
            YearBalanceHiveModel(year: year, months: []);

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
  Future<List<TransactionHiveModel>> getTransactionsModels(
      {required int monthIndex}) async {
    final values = _transactionBox.values.toList();

    final filtered = values.where((transaction) {
      return transaction.transactionDate.month == monthIndex;
    }).toList();

    return filtered;
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
  Future<YearBalanceHiveModel?> getTransactionsByYear({int? year}) async {
    final selectedYear = year ?? DateTime.now().year;

    final yearTransactions = _yearBalanceBox.get(selectedYear.toString());

    return yearTransactions;
  }
}
