import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

class Transaction with EquatableMixin {
  final String? id;
  final TransactionTypEnum type;
  final DateTime transactionDate;
  final int amount;
  final String? categoryType;
  final String? sourceType;

  Transaction(
      {this.id,
      required this.type,
      required this.transactionDate,
      required this.amount,
      this.categoryType,
      this.sourceType});

  factory Transaction.initial() {
    final transactionDate = DateTime.now();
    return Transaction(
        type: TransactionTypEnum.income,
        transactionDate: transactionDate,
        amount: 0);
  }

  Transaction copyWith(
      {String? id,
      TransactionTypEnum? type,
      DateTime? transactionDate,
      int? amount,
      String? categoryType,
      String? sourceType}) {
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
