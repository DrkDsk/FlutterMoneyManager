import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class TransactionEntity {
  final String? id;
  final TransactionType type;
  final DateTime transactionDate;
  final int amount;
  final TransactionCategory category;
  final TransactionSource source;

  const TransactionEntity(
      {this.id,
      required this.type,
      required this.transactionDate,
      required this.amount,
      required this.category,
      required this.source});
}
