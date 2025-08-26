import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static Future<Box<TransactionHiveModel>> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());

    return await Hive.openBox<TransactionHiveModel>(hiveTransactionBoxName);
  }
}
