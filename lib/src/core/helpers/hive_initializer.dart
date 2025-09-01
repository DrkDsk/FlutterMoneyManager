import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/enums/expense_category_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveInitializer {
  static Future<Box<TransactionHiveModel>> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TransactionTypeEnumAdapter());
    Hive.registerAdapter(TransactionCategoryEnumAdapter());
    Hive.registerAdapter(TransactionSourceEnumAdapter());
    Hive.registerAdapter(TransactionHiveModelAdapter());

    return await Hive.openBox<TransactionHiveModel>(hiveTransactionBoxName);
  }
}
