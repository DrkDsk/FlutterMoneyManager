import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

enum CreateTransactionStatus { initial, loading, error, success }

class CreateTransactionState with EquatableMixin {
  final Transaction transaction;
  final bool formIsValidated;
  final CreateTransactionStatus status;

  CreateTransactionState(
      {Transaction? transaction,
      this.formIsValidated = false,
      this.status = CreateTransactionStatus.initial})
      : transaction = transaction ??
            Transaction(
              amount: 0,
              type: kIncomeType,
            );

  CreateTransactionState copyWith(
      {Transaction? transaction,
      bool? formIsValidated,
      CreateTransactionStatus? status}) {
    return CreateTransactionState(
        transaction: transaction ?? this.transaction,
        formIsValidated: formIsValidated ?? this.formIsValidated,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [transaction, formIsValidated, status];
}
