import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class CreateTransactionState with EquatableMixin {
  final DateTime transactionDate;
  final String amount;
  final Transactioncategory? transactioncategory;

  CreateTransactionState({
    required this.transactionDate,
    required this.amount,
    this.transactioncategory,
  });

  CreateTransactionState copyWith({
    DateTime? transactionDate,
    String? amount,
    Transactioncategory? transactioncategory,
  }) {
    return CreateTransactionState(
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      transactioncategory: transactioncategory ?? this.transactioncategory,
    );
  }

  @override
  List<Object?> get props => [transactionDate, amount, transactioncategory];
}
