import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class TransactionEntity with EquatableMixin {
  final String? id;
  final TransactionType type;
  final DateTime transactionDate;
  final String amount;
  final TransactionCategory? category;
  final TransactionSource? source;

  TransactionEntity(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.category,
      this.source})
      : transactionDate = transactionDate ?? DateTime.now();

  TransactionEntity copyWith({
    String? id,
    TransactionType? type,
    DateTime? transactionDate,
    String? amount,
    TransactionCategory? category,
    TransactionSource? source,
  }) {
    return TransactionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, category, source];
}
