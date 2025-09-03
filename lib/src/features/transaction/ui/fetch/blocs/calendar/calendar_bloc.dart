import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState.initial()) {
    on<UpdateFocusedDate>(updateFocusedDate);
    on<UpdateSelectedDate>(updateSelectedDate);
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
}
