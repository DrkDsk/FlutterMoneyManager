import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final DateTime transactionDate;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final String categoryType;

  @HiveField(5)
  final String sourceType;

  TransactionHiveModel({
    required this.id,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.categoryType,
    required this.sourceType,
  });

  factory TransactionHiveModel.fromModel(TransactionModel model) {
    return TransactionHiveModel(
        id: model.id ?? "",
        type: model.type.name,
        transactionDate: model.transactionDate,
        amount: model.amount,
        categoryType: model.categoryType ?? "",
        sourceType: model.sourceType ?? "");
  }
}
