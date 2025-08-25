import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class CreateTransactionState with EquatableMixin {
  final Transaction transaction;
  final bool formIsValidated;

  CreateTransactionState(
      {Transaction? transaction, this.formIsValidated = false})
      : transaction = transaction ??
            Transaction(
              amount: kDefaultAmountValue,
              type: TransactionTypeEnum.income,
            );

  CreateTransactionState copyWith(
      {Transaction? transaction, bool? formIsValidated}) {
    return CreateTransactionState(
        transaction: transaction ?? this.transaction,
        formIsValidated: formIsValidated ?? this.formIsValidated);
  }

  @override
  List<Object?> get props => [transaction, formIsValidated];
}
