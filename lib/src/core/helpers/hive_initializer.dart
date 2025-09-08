import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
    Hive.registerAdapter(TransactionSourceHiveModelAdapter());
    Hive.registerAdapter(GlobalBalanceHiveModelAdapter());
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
      getGloTransactionHiveModel() async {
    return await Hive.openBox<GlobalBalanceHiveModel>(hiveGlobalBalanceBoxName);
  }
}
