import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  CreateTransactionCubit()
      : super(CreateTransactionState(
            transactionDate: DateTime.now(), amount: kDefaultAmountValue));

  void updateAmountDate(DateTime? time) {
    emit(state.copyWith(transactionDate: time));
  }

  void updateAmount(String? amount) {
    emit(state.copyWith(amount: amount));
    print("state: $state");
  }
}
