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
    on<UpdateSelectedDate>(_updateSelectedDate);
    on<UpdateTopFiveType>(_updateTopFiveType);
  }

  Future<void> _fetchSummaryEvent(
      FetchSummaryEvent event, Emitter<SummaryState> emit) async {
    final previousMonthIndex = event.previousMonthIndex;
    final currentMonthIndex = state.selectedMonth;
    final year = state.selectedYear;

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
    final monthIndex = state.selectedMonth;
    final yearIndex = state.selectedYear;
    final type = state.selectedTypeForChart;

    final result = await _financialSummaryRepository.getTopFiveSummary(
        month: monthIndex, year: yearIndex, type: type);

    emit(state.copyWith(topFiveSummary: result));
  }

  Future<void> _updateSelectedDate(
      UpdateSelectedDate event, Emitter<SummaryState> emit) async {
    final month = event.month;
    final year = event.year;

    emit(state.copyWith(selectedMonth: month, selectedYear: year));
  }

  Future<void> _updateTopFiveType(
      UpdateTopFiveType event, Emitter<SummaryState> emit) async {
    final type = event.type;

    emit(state.copyWith(selectedTypeForChart: type));
    add(const FetchTopFiveExpense());
  }
}
