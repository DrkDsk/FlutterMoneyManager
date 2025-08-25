import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class CreateTransactionState with EquatableMixin {
  final Transaction transactionEntity;
  final bool formIsValidated;

  CreateTransactionState(
      {Transaction? transactionEntity, this.formIsValidated = false})
      : transactionEntity = transactionEntity ??
            Transaction(
              amount: kDefaultAmountValue,
              type: TransactionTypeEnum.income,
            );

  CreateTransactionState copyWith(
      {Transaction? transaction, bool? formIsValidated}) {
    return CreateTransactionState(
        transactionEntity: transaction ?? transactionEntity,
        formIsValidated: formIsValidated ?? this.formIsValidated);
  }

  @override
  List<Object?> get props => [transactionEntity, formIsValidated];
}
