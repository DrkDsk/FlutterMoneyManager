import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_entity.dart';

class CreateTransactionState with EquatableMixin {
  final TransactionEntity transactionEntity;
  final bool formIsValidated;

  CreateTransactionState(
      {TransactionEntity? transactionEntity, this.formIsValidated = false})
      : transactionEntity = transactionEntity ??
            TransactionEntity(
              amount: kDefaultAmountValue,
              type: TransactionType.income,
            );

  CreateTransactionState copyWith(
      {TransactionEntity? transaction, bool? formIsValidated}) {
    return CreateTransactionState(
        transactionEntity: transaction ?? transactionEntity,
        formIsValidated: formIsValidated ?? this.formIsValidated);
  }

  @override
  List<Object?> get props => [transactionEntity, formIsValidated];
}
