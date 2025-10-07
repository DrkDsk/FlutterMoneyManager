import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final TransactionRepository _repository;

  SummaryBloc({required TransactionRepository repository})
      : _repository = repository,
        super(SummaryState.initial()) {
    on<FetchSummaryEvent>(_fetchSummaryEvent);
  }

  Future<void> _fetchSummaryEvent(
      FetchSummaryEvent event, Emitter<SummaryState> emit) async {
    final previousMonthIndex = event.previousMonthIndex;
    final currentMonthIndex = event.currentMonthIndex;
    final year = event.year;

    final result = await _repository.getComparisonByMonths(
        currentMonth: currentMonthIndex,
        previousMonth: previousMonthIndex,
        year: year);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: SummaryTypeStatus.error,
          message: failure.message,
        ));
      },
      (success) {
        emit(state.copyWith(
          status: SummaryTypeStatus.success,
          currentMonthlySummary: success.currentMonthlySummary,
          lastMonthlySummary: success.lastMonthlySummary,
        ));
      },
    );
  }
}
