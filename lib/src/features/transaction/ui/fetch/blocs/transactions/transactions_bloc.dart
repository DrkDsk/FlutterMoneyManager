import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'transactions_state.dart';
import 'transactions_event.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsListState> {
  final TransactionRepository _repository;
  late final StreamSubscription _subscription;

  TransactionsBloc({required TransactionRepository repository})
      : _repository = repository,
        super(TransactionsListState.initial()) {
    _subscription = _repository.transactionsStream().listen((balance) {
      add(UpdateBalance(balance: balance));
    });

    on<LoadTransactionsByMonth>(getTransactionsByMonth);
    on<UpdateMonth>(updateMonth);
    on<UpdateBalance>(_updateBalance);
    on<DeleteTransaction>(_deleteTransaction);
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

  Future<void> _updateBalance(
      UpdateBalance event, Emitter<TransactionsListState> emit) async {
    final balance = event.balance;

    emit(state.copyWith(
        total: balance.total,
        income: balance.income,
        expense: balance.expense));
  }

  Future<void> _deleteTransaction(
      DeleteTransaction event, Emitter<TransactionsListState> emit) async {
    final transactionId = event.id;

    final result = await _repository.delete(id: transactionId);

    result.fold((left) {}, (right) {});
  }

  Future<void> getTransactionsByMonth(LoadTransactionsByMonth event,
      Emitter<TransactionsListState> emit) async {
    emit(state.copyWith(status: TransactionTypeStatus.loading));

    final month = event.month;
    final year = event.year;

    final request =
        await _repository.getTransactionsByMonth(month: month, year: year);

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

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
