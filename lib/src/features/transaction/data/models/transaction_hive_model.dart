import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_entity.dart';
import 'package:hive/hive.dart';

import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:uuid/uuid.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final TransactionType type;

  @HiveField(2)
  final DateTime transactionDate;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final TransactionCategory category;

  @HiveField(5)
  final TransactionSource source;

  TransactionHiveModel({
    required this.id,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.category,
    required this.source,
  });

  TransactionHiveModel copyWith({
    String? id,
    TransactionType? type,
    DateTime? transactionDate,
    int? amount,
    TransactionCategory? category,
    TransactionSource? source,
  }) {
    return TransactionHiveModel(
      id: id ?? this.id,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      source: source ?? this.source,
    );
  }

  factory TransactionHiveModel.fromEntity(TransactionEntity entity) {
    return TransactionHiveModel(
        id: entity.id ?? const Uuid().v4(),
        amount: entity.amount,
        category: entity.category,
        source: entity.source,
        transactionDate: entity.transactionDate,
        type: entity.type);
  }
}
