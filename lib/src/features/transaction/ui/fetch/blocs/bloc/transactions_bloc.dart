import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import './transactions_state.dart';
import './transactions_event.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsListState> {
  final TransactionRepository _repository;

  TransactionsBloc({required TransactionRepository repository})
      : _repository = repository,
        super(TransactionsListState.initial()) {
    on<LoadTransactionsByMonth>(getTransactionsByMonth);
  }

  Future<void> getTransactionsByMonth(LoadTransactionsByMonth event,
      Emitter<TransactionsListState> emit) async {
    emit(state.copyWith(status: TransactionTypeStatus.loading));

    final monthIndex = event.monthIndex;

    final request =
        await _repository.getTransactionsByMonth(monthIndex: monthIndex);

    request.fold((left) {
      emit(state.copyWith(
          status: TransactionTypeStatus.error, message: left.message));
    }, (right) {
      final data = right;

      emit(state.copyWith(
          transactions: data.transactionsData,
          income: data.income,
          expense: data.expense,
          total: data.total,
          status: TransactionTypeStatus.success));
    });
  }
}
