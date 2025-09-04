import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
  }

  static Future<Box<TransactionHiveModel>> getTransactionsBox() async {
    return await Hive.openBox<TransactionHiveModel>(hiveTransactionBoxName);
  }

  static Future<Box<TransactionSourceHiveModel>>
      getTransactionsSourceBox() async {
    return await Hive.openBox<TransactionSourceHiveModel>(
        hiveTransactionSourceBoxName);
  }
}
