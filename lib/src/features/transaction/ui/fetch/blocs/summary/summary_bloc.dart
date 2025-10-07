import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  final TransactionRepository _transactionRepository;
  final FinancialSummaryRepository _financialSummaryRepository;

  SummaryBloc(
      {required TransactionRepository transactionRepository,
      required FinancialSummaryRepository financialSummaryRepository})
      : _transactionRepository = transactionRepository,
        _financialSummaryRepository = financialSummaryRepository,
        super(SummaryState.initial()) {
    on<FetchSummaryEvent>(_fetchSummaryEvent);
    on<FetchTopFiveExpense>(_fetchTopFiveExpense);
  }

  Future<void> _fetchSummaryEvent(
      FetchSummaryEvent event, Emitter<SummaryState> emit) async {
    final previousMonthIndex = event.previousMonthIndex;
    final currentMonthIndex = event.currentMonthIndex;
    final year = event.year;

    final result = await _transactionRepository.getComparisonByMonths(
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

  Future<void> _fetchTopFiveExpense(
      FetchTopFiveExpense event, Emitter<SummaryState> emit) async {
    final monthIndex = event.month;
    final yearIndex = event.year;

    final result = await _financialSummaryRepository.getTopFiveSummary(
        month: monthIndex, year: yearIndex);

    emit(state.copyWith(topFiveSummary: result));
  }
}
