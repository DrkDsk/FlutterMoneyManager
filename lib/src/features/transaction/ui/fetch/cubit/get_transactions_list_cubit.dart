import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

import 'get_transactions_list_state.dart';

class GetTransactionsListCubit extends Cubit<GetTransactionListState> {
  final TransactionRepository _repository;

  GetTransactionsListCubit({required TransactionRepository repository})
      : _repository = repository,
        super(GetTransactionListState());

  Future<void> getTransactions({int? monthIndex}) async {
    emit(state.copyWith(status: GetTransactionListStatus.loading));

    final request =
        await _repository.getTransactionsByMonth(monthIndex: monthIndex);

    request.fold((left) {
      emit(state.copyWith(
          status: GetTransactionListStatus.error, errorMessage: left.message));
    }, (right) {
      final data = right;

      emit(state.copyWith(
          transactions: data.transactionsData,
          income: data.income,
          expense: data.expense,
          total: data.total,
          status: GetTransactionListStatus.success));
    });
  }

  void previousPageIndex() {
    final currentIndex = state.indexMonth;

    if (currentIndex == 1) return;

    updateMonthName(currentIndex - 1);
  }

  void nextPage() {
    final currentIndex = state.indexMonth;

    if (currentIndex == 12) return;

    updateMonthName(currentIndex + 1);
  }

  void updateMonthName(int indexMonth) {
    final now = DateTime.now();
    final currentDate = DateTime(now.year, indexMonth);

    emit(state.copyWith(
        monthName: currentDate.monthName, indexMonth: indexMonth));
  }

  void updateIndex(int index) {
    if (index < 1 || index > 12) {
      return;
    }

    updateMonthName(index);
  }
}
