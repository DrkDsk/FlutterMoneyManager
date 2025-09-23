import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  static init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
    Hive.registerAdapter(TransactionSourceHiveModelAdapter());
  }

  static Future<Box<TransactionHiveModel>> getTransactionsBox() async {
    return await Hive.openBox<TransactionHiveModel>(
        HiveConstants.transactionsBox);
  }

  static Future<Box<TransactionSourceHiveModel>>
      getTransactionsSourceBox() async {
    return await Hive.openBox<TransactionSourceHiveModel>(
        HiveConstants.hiveTransactionSourceBoxName);
  }

  static String generateTransactionDayKey({required DateTime date}) {
    final year = date.year;
    final monthNumber = date.month;
    final dayNumber = date.day;

    final month = monthNumber < 10 ? "0$monthNumber" : monthNumber;
    final day = dayNumber < 10 ? "0$dayNumber" : "$dayNumber";

    return "$day-$month-$year";
  }
}
