import 'package:bloc/bloc.dart';

import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  final TransactionRepository _repository;

  CreateTransactionCubit({required TransactionRepository repository})
      : _repository = repository,
        super(CreateTransactionState());

  void updateAmountDate(DateTime? time) {
    final transaction = state.transaction.copyWith(transactionDate: time);
    final newState = state.copyWith(transaction: transaction);

    emit(_validForm(newState));
  }

  void updateAmount(int? amount) {
    final transaction = state.transaction.copyWith(amount: amount);
    final newState =
        state.copyWith(transaction: transaction.copyWith(amount: amount));

    emit(_validForm(newState));
  }

  void updateTransactionSource(PaymentSource source) {
    final transaction = state.transaction;
    final newState = state.copyWith(
        transaction: transaction.copyWith(sourceType: source.getType()));

    emit(_validForm(newState));
  }

  void updateTransactionCategory(TransactionCategory source) {
    final transaction = state.transaction;
    final category = source.getCategoryType();

    final newState = state.copyWith(
        transaction: transaction.copyWith(categoryType: category));

    emit(_validForm(newState));
  }

  CreateTransactionState _validForm(CreateTransactionState newState) {
    final transaction = newState.transaction;

    final amount = transaction.amount;
    final transactionSource = transaction.sourceType;
    final transactionCategory = transaction.categoryType;

    final bool formIsValidated = (transactionSource == null ||
            transactionCategory == null ||
            amount == 0)
        ? false
        : true;

    return newState.copyWith(formIsValidated: formIsValidated);
  }

  void updateTransactionType(int index) {
    final transaction = state.transaction;

    final transactionSelected = kDefaultTransactionTypes[index];

    emit(state.copyWith(
        transaction: transaction.copyWith(type: transactionSelected.type)));
  }

  Future<void> saveTransaction() async {
    final transaction = state.transaction;

    emit(state.copyWith(status: CreateTransactionStatus.loading));

    final result = await _repository.saveTransaction(transaction);

    result.fold((left) {
      emit(state.copyWith(status: CreateTransactionStatus.error));
    }, (right) {
      emit(state.copyWith(status: CreateTransactionStatus.success));
    });
  }
}
