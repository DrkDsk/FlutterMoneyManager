import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class CreateTransactionState with EquatableMixin {
  final DateTime transactionDate;
  final String amount;
  final TransactionSource? transactionSource;
  final TransactionCategory? transactionCategory;
  final bool formIsValidated;
  final TransactionType transactionType;

  CreateTransactionState(
      {required this.transactionDate,
      this.amount = kDefaultAmountValue,
      this.transactionSource,
      this.transactionCategory,
      this.formIsValidated = false,
      this.transactionType = TransactionType.income});

  CreateTransactionState copyWith(
      {DateTime? transactionDate,
      String? amount,
      TransactionSource? transactionSource,
      TransactionCategory? transactionCategory,
      bool? formIsValidated,
      TransactionType? transactionType}) {
    return CreateTransactionState(
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        transactionSource: transactionSource ?? this.transactionSource,
        transactionCategory: transactionCategory ?? this.transactionCategory,
        formIsValidated: formIsValidated ?? this.formIsValidated,
        transactionType: transactionType ?? this.transactionType);
  }

  @override
  List<Object?> get props => [
        transactionDate,
        amount,
        transactionSource,
        transactionCategory,
        formIsValidated,
      ];
}
