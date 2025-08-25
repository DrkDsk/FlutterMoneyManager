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
  final int tabIndex;

  CreateTransactionState(
      {required this.transactionDate,
      this.amount = kDefaultAmountValue,
      this.transactionSource,
      this.transactionCategory,
      this.tabIndex = 0,
      this.formIsValidated = false});

  CreateTransactionState copyWith({
    DateTime? transactionDate,
    String? amount,
    TransactionSource? transactionSource,
    TransactionCategory? transactionCategory,
    bool? formIsValidated,
    int? tabIndex,
  }) {
    return CreateTransactionState(
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        transactionSource: transactionSource ?? this.transactionSource,
        transactionCategory: transactionCategory ?? this.transactionCategory,
        formIsValidated: formIsValidated ?? this.formIsValidated,
        tabIndex: tabIndex ?? this.tabIndex);
  }

  @override
  List<Object?> get props => [
        transactionDate,
        amount,
        transactionSource,
        transactionCategory,
        formIsValidated,
        tabIndex
      ];
}
