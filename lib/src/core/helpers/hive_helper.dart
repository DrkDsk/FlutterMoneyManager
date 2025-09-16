import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
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

  static String generateYearlyTransactionKey({required int year}) {
    final selectedYear = year;

    return "transactions_year_$selectedYear";
  }

  static String generateYearlyBalanceKey({required int year}) {
    final selectedYear = year;

    return "balance_year_$selectedYear";
  }
}
