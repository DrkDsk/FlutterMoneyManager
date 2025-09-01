import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_category_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

class Transaction with EquatableMixin {
  final String? id;
  final TransactionTypeEnum type;
  final DateTime transactionDate;
  final int amount;
  final TransactionCategoryEnum? categoryType;
  final TransactionSourceEnum? sourceType;

  Transaction(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.categoryType,
      this.sourceType})
      : transactionDate = transactionDate ?? DateTime.now();

  Transaction copyWith(
      {String? id,
      TransactionTypeEnum? type,
      DateTime? transactionDate,
      int? amount,
      TransactionCategoryEnum? categoryType,
      TransactionSourceEnum? sourceType}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        categoryType: categoryType ?? this.categoryType,
        sourceType: sourceType ?? this.sourceType);
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, categoryType, sourceType];
}
