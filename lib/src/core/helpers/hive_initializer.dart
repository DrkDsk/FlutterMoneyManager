import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_month_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_year_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/balance_year_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
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

  static Future<Box<TransactionHiveModel>> getTransactionsBox() async {
    return await Hive.openBox<TransactionHiveModel>(hiveTransactionBoxName);
  }

  static Future<Box<TransactionSourceHiveModel>>
      getTransactionsSourceBox() async {
    return await Hive.openBox<TransactionSourceHiveModel>(
        hiveTransactionSourceBoxName);
  }

  static Future<Box<GlobalBalanceHiveModel>>
      getGlobalTransactionHiveBox() async {
    return await Hive.openBox<GlobalBalanceHiveModel>(hiveGlobalBalanceBoxName);
  }

  static Future<Box<BalanceYearHiveModel>> getBalanceYearHiveBox() async {
    return await Hive.openBox<BalanceYearHiveModel>(hiveYearBalanceBoxName);
  }

  static Future<Box<TransactionsYearHiveModel>>
      getTransactionYearHiveBox() async {
    return await Hive.openBox<TransactionsYearHiveModel>(
        hiveYearTransactionsBoxName);
  }
}
