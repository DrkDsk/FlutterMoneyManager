import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_month_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/balance_year_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
    Hive.registerAdapter(TransactionSourceHiveModelAdapter());
    Hive.registerAdapter(GlobalBalanceHiveModelAdapter());
    Hive.registerAdapter(MonthBalanceHiveModelAdapter());
    Hive.registerAdapter(BalanceYearHiveModelAdapter());
    Hive.registerAdapter(TransactionsMonthHiveModelAdapter());
    Hive.registerAdapter(TransactionsYearHiveModelAdapter());
  }

  static Future<Box<TransactionSourceHiveModel>>
      getTransactionsSourceBox() async {
    return await Hive.openBox<TransactionSourceHiveModel>(
        HiveConstants.hiveTransactionSourceBoxName);
  }

  static Future<Box<GlobalBalanceHiveModel>>
      getGlobalTransactionHiveBox() async {
    return await Hive.openBox<GlobalBalanceHiveModel>(
        HiveConstants.hiveGlobalBalanceBoxName);
  }

  static Future<Box<BalanceYearHiveModel>> getBalanceYearHiveBox() async {
    return await Hive.openBox<BalanceYearHiveModel>(
        HiveConstants.hiveYearBalanceBoxName);
  }

  static Future<Box<TransactionsYearHiveModel>>
      getTransactionYearHiveBox() async {
    return await Hive.openBox<TransactionsYearHiveModel>(
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

  static String generateTransactionYearKey({required DateTime date}) {
    final year = date.year;

    return "$year";
  }
}
