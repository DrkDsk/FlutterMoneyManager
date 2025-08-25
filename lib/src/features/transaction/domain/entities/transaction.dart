import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class Transaction with EquatableMixin {
  final String? id;
  final TransactionTypeEnum type;
  final DateTime transactionDate;
  final String amount;
  final TransactionCategory? category;
  final TransactionSource? source;

  Transaction(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.category,
      this.source})
      : transactionDate = transactionDate ?? DateTime.now();

  Transaction copyWith(
      {String? id,
      TransactionTypeEnum? type,
      DateTime? transactionDate,
      String? amount,
      TransactionCategory? category,
      TransactionSource? source}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        source: source ?? this.source);
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, category, source];
}
