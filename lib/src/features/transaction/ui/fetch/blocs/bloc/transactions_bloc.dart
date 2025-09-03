import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import './transactions_state.dart';
import './transactions_event.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsListState> {
  final TransactionRepository _repository;

  TransactionsBloc({required TransactionRepository repository})
      : _repository = repository,
        super(TransactionsListState.initial()) {
    on<LoadTransactionsByMonth>(getTransactionsByMonth);
    on<UpdateMonth>(updateMonth);
  }

  int? nextIndex() {
    final currentIndex = state.monthIndex;

    if (currentIndex == 12) return null;

    return currentIndex + 1;
  }

  int? prevIndex() {
    final currentIndex = state.monthIndex;

    if (currentIndex == 1) return null;

    return currentIndex - 1;
  }

  void updateMonth(UpdateMonth event, Emitter<TransactionsListState> emit) {
    final monthIndex = event.monthIndex;

    final now = DateTime.now();
    final currentDate = DateTime(now.year, monthIndex);

    emit(state.copyWith(
        monthName: currentDate.monthName, monthIndex: monthIndex));
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
