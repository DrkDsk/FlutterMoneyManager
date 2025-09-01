import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

import './get_transactions_list_state.dart';

class GetTransactionsListCubit extends Cubit<GetTransactionListState> {
  final TransactionRepository _repository;

  GetTransactionsListCubit({required TransactionRepository repository})
      : _repository = repository,
        super(const GetTransactionListState());

  Future<void> getTransactions() async {
    emit(state.copyWith(status: GetTransactionListStatus.loading));

    final request = await _repository.getTransactions();

    request.fold((left) {
      emit(state.copyWith(
          status: GetTransactionListStatus.error, errorMessage: left.message));
    }, (right) {
      final transactions = right;

      emit(state.copyWith(
          transactions: transactions,
          status: GetTransactionListStatus.success));
    });
  }
}
