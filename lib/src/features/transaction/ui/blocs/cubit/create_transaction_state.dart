import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class CreateTransactionState with EquatableMixin {
  final DateTime transactionDate;
  final String amount;
  final PaymentSource? paymentSource;
  final TransactionCategory? transactionCategory;

  CreateTransactionState(
      {required this.transactionDate,
      required this.amount,
      this.paymentSource,
      this.transactionCategory});

  CreateTransactionState copyWith(
      {DateTime? transactionDate,
      String? amount,
      PaymentSource? paymentSource,
      TransactionCategory? transactionCategory}) {
    return CreateTransactionState(
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        paymentSource: paymentSource ?? this.paymentSource,
        transactionCategory: transactionCategory ?? this.transactionCategory);
  }

  @override
  List<Object?> get props =>
      [transactionDate, amount, paymentSource, transactionCategory];
}
