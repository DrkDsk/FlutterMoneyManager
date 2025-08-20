import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';

class CreateTransactionState with EquatableMixin {
  final DateTime transactionDate;
  final String amount;
  final PaymentSource? paymentSource;

  CreateTransactionState({
    required this.transactionDate,
    required this.amount,
    this.paymentSource,
  });

  CreateTransactionState copyWith({
    DateTime? transactionDate,
    String? amount,
    PaymentSource? paymentSource,
  }) {
    return CreateTransactionState(
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      paymentSource: paymentSource ?? this.paymentSource,
    );
  }

  @override
  List<Object?> get props => [transactionDate, amount, paymentSource];
}
