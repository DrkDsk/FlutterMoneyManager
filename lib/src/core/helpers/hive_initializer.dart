import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionHiveModelAdapter());
  }
}
