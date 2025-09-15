import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
    Hive.registerAdapter(TransactionSourceHiveModelAdapter());
    Hive.registerAdapter(FinancialSummaryHiveModelAdapter());
    Hive.registerAdapter(MonthlyFinancialSummaryHiveModelAdapter());
    Hive.registerAdapter(YearlyFinancialSummaryHiveModelAdapter());
    Hive.registerAdapter(MonthlyTransactionsHiveModelAdapter());
    Hive.registerAdapter(YearlyTransactionsHiveModelAdapter());
  }

  static Future<Box<TransactionSourceHiveModel>>
      getTransactionsSourceBox() async {
    return await Hive.openBox<TransactionSourceHiveModel>(
        HiveConstants.hiveTransactionSourceBoxName);
  }

  static Future<Box<FinancialSummaryHiveModel>>
      getGlobalTransactionHiveBox() async {
    return await Hive.openBox<FinancialSummaryHiveModel>(
        HiveConstants.hiveGlobalBalanceBoxName);
  }

  static Future<Box<YearlyFinancialSummaryHiveModel>>
      getBalanceYearHiveBox() async {
    return await Hive.openBox<YearlyFinancialSummaryHiveModel>(
        HiveConstants.hiveYearBalanceBoxName);
  }

  static Future<Box<YearlyTransactionsHiveModel>>
      getTransactionYearHiveBox() async {
    return await Hive.openBox<YearlyTransactionsHiveModel>(
        HiveConstants.hiveYearTransactionsBoxName);
  }

  static String generateTransactionDayKey({required DateTime date}) {
    final year = date.year;
    final monthNumber = date.month;
    final dayNumber = date.day;

    final month = monthNumber < 10 ? "0$monthNumber" : monthNumber;
    final day = dayNumber < 10 ? "0$dayNumber" : "$dayNumber";

    return "$day-$month-$year";
  }

  static String generateYearlyTransactionKey({int? year}) {
    final selectedYear = year;
    if (selectedYear == null) {
      throw ArgumentError(
          "A date or a year must be provided to generate the key.");
    }
    return "transactions_year_$selectedYear";
  }

  static String generateYearlyBalanceKey({int? year}) {
    final selectedYear = year;
    if (selectedYear == null) {
      throw ArgumentError(
          "A date or a year must be provided to generate the key.");
    }
    return "balance_year_$selectedYear";
  }
}
