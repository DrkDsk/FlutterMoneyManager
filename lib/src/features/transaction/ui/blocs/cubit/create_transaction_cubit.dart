import 'package:bloc/bloc.dart';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  CreateTransactionCubit() : super(CreateTransactionState());

  void updateAmountDate(DateTime? time) {
    final transaction = state.transactionEntity.copyWith(transactionDate: time);
    final newState = state.copyWith(transaction: transaction);

    emit(_validForm(newState));
  }

  void updateAmount(String? amount) {
    final transaction = state.transactionEntity.copyWith(amount: amount);
    final newState =
        state.copyWith(transaction: transaction.copyWith(amount: amount));

    emit(_validForm(newState));
  }

  void updateTransactionSource(TransactionSource source) {
    final transaction = state.transactionEntity;
    final newState =
        state.copyWith(transaction: transaction.copyWith(source: source));

    emit(_validForm(newState));
  }

  void updateTransactionCategory(TransactionCategory category) {
    final transaction = state.transactionEntity;
    final newState =
        state.copyWith(transaction: transaction.copyWith(category: category));

    emit(_validForm(newState));
  }

  CreateTransactionState _validForm(CreateTransactionState newState) {
    final transaction = newState.transactionEntity;

    final amount = transaction.amount.replaceAll("\$ ", "").replaceAll(" ", "");
    final transactionSource = transaction.source;
    final transactionCategory = transaction.category;

    final bool formIsValidated = (transactionSource == null ||
            transactionCategory == null ||
            amount == "0" ||
            amount.isEmpty)
        ? false
        : true;

    return newState.copyWith(formIsValidated: formIsValidated);
  }

  void updateTransactionType(int index) {
    final transaction = state.transactionEntity;

    final transactionSelected = kDefaultTransactionTypes[index];

    emit(state.copyWith(
        transaction: transaction.copyWith(type: transactionSelected.type)));
  }

  void saveTransaction() {}
}
