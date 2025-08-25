import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class CreateTransactionState with EquatableMixin {
  final DateTime transactionDate;
  final String amount;
  final TransactionSource? transactionSource;
  final TransactionCategory? transactionCategory;
  final bool formIsValidated;

  CreateTransactionState(
      {required this.transactionDate,
      this.amount = kDefaultAmountValue,
      this.transactionSource,
      this.transactionCategory,
      this.formIsValidated = false});

  CreateTransactionState copyWith(
      {DateTime? transactionDate,
      String? amount,
      TransactionSource? transactionSource,
      TransactionCategory? transactionCategory,
      bool? formIsValidated}) {
    return CreateTransactionState(
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        transactionSource: transactionSource ?? this.transactionSource,
        transactionCategory: transactionCategory ?? this.transactionCategory,
        formIsValidated: formIsValidated ?? this.formIsValidated);
  }

  @override
  List<Object?> get props => [
        transactionDate,
        amount,
        transactionSource,
        transactionCategory,
        formIsValidated
      ];
}
