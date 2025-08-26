import 'package:flutter_money_manager/src/core/enums/transaction_category_enum.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final TransactionTypeEnum type;

  @HiveField(2)
  final DateTime transactionDate;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final TransactionCategoryEnum categoryType;

  @HiveField(5)
  final TransactionSourceEnum sourceType;

  TransactionHiveModel({
    required this.id,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.categoryType,
    required this.sourceType,
  });

  TransactionHiveModel copyWith({
    String? id,
    TransactionTypeEnum? type,
    DateTime? transactionDate,
    int? amount,
    TransactionCategoryEnum? categoryType,
    TransactionSourceEnum? sourceType,
  }) {
    return TransactionHiveModel(
      id: id ?? this.id,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      categoryType: categoryType ?? this.categoryType,
      sourceType: sourceType ?? this.sourceType,
    );
  }

  factory TransactionHiveModel.fromEntity(Transaction entity) {
    return TransactionHiveModel(
        id: entity.id ?? const Uuid().v4(),
        amount: entity.amount,
        categoryType: entity.categoryType!,
        sourceType: entity.sourceType!,
        transactionDate: entity.transactionDate,
        type: entity.type);
  }
}
