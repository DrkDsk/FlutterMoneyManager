import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final TransactionRepository _repository;

  CalendarBloc({required TransactionRepository repository})
      : _repository = repository,
        super(CalendarState.initial()) {
    on<UpdateFocusedDate>(updateFocusedDate);
    on<UpdateSelectedDate>(updateSelectedDate);
    on<UpdateTitleCalendar>(updateTitleCalendar);
    on<FilterTransactionsByDay>(getTransactionsByDate);
  }

  Future<void> updateFocusedDate(
      UpdateFocusedDate event, Emitter<CalendarState> emit) async {
    final date = event.focusedDate;

    emit(state.copyWith(focusedDate: date));
  }

  Future<void> updateSelectedDate(
      UpdateSelectedDate event, Emitter<CalendarState> emit) async {
    final date = event.selectedDate;

    emit(state.copyWith(selectedDate: date));
  }

  Future<void> updateTitleCalendar(
      UpdateTitleCalendar event, Emitter<CalendarState> emit) async {
    final titleCalendar = event.titleCalendar;

    emit(state.copyWith(titleCalendar: titleCalendar));
  }

  Future<void> getTransactionsByDate(
      FilterTransactionsByDay event, Emitter<CalendarState> emit) async {
    final selectedDate = event.selectedDay;

    final request =
        await _repository.getTransactionSummaryByDate(date: selectedDate);

    request.fold((left) {
      emit(state.copyWith(message: left.message));
    }, (right) {
      final data = right;

      emit(state.copyWith(
        transactions: data.transactionsData,
      ));
    });
  }
}
