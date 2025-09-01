import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/expense_category_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

class Transaction with EquatableMixin {
  final String? id;
  final TransactionTypeEnum type;
  final DateTime transactionDate;
  final int amount;
  final ExpenseCategoryEnum? expenseCategoryType;
  final PaymentSourceEnum? sourceType;

  Transaction(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.expenseCategoryType,
      this.sourceType})
      : transactionDate = transactionDate ?? DateTime.now();

  Transaction copyWith(
      {String? id,
      TransactionTypeEnum? type,
      DateTime? transactionDate,
      int? amount,
      ExpenseCategoryEnum? expenseCategoryType,
      PaymentSourceEnum? sourceType}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        expenseCategoryType: expenseCategoryType ?? this.expenseCategoryType,
        sourceType: sourceType ?? this.sourceType);
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, expenseCategoryType, sourceType];
}
