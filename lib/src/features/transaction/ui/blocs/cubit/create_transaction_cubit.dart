import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  CreateTransactionCubit()
      : super(CreateTransactionState(transactionDate: DateTime.now()));

  void updateAmountDate(DateTime? time) {
    final newState = state.copyWith(transactionDate: time);
    emit(_validForm(newState));
  }

  void updateAmount(String? amount) {
    final newState = state.copyWith(amount: amount);
    emit(_validForm(newState));
  }

  void updateTransactionSource(TransactionSource transactionSource) {
    final newState = state.copyWith(transactionSource: transactionSource);
    emit(_validForm(newState));
  }

  void updateTransactionCategory(TransactionCategory category) {
    final newState = state.copyWith(transactionCategory: category);
    emit(_validForm(newState));
  }

  CreateTransactionState _validForm(CreateTransactionState newState) {
    final amount = newState.amount.replaceAll("\$ ", "").replaceAll(" ", "");
    final transactionSource = newState.transactionSource;
    final transactionCategory = newState.transactionCategory;

    final bool formIsValidated = (transactionSource == null ||
            transactionCategory == null ||
            amount == "0" ||
            amount.isEmpty)
        ? false
        : true;

    return newState.copyWith(formIsValidated: formIsValidated);
  }

  void updateTabIndex(int index) {
    emit(state.copyWith(tabIndex: index));
  }
}
