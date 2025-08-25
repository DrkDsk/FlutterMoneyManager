import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class Transaction with EquatableMixin {
  final String? id;
  final TransactionTypeEnum type;
  final DateTime transactionDate;
  final String amount;
  final TransactionCategory? category;
  final TransactionSourceEnum? sourceType;

  Transaction(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.category,
      this.sourceType})
      : transactionDate = transactionDate ?? DateTime.now();

  Transaction copyWith(
      {String? id,
      TransactionTypeEnum? type,
      DateTime? transactionDate,
      String? amount,
      TransactionCategory? category,
      TransactionSourceEnum? sourceType}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        sourceType: sourceType ?? this.sourceType);
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, category, sourceType];
}
