import 'package:equatable/equatable.dart';

sealed class CalendarEvent {
  const CalendarEvent();
}

class UpdateFocusedDate extends CalendarEvent with EquatableMixin {
  final DateTime focusedDate;

  const UpdateFocusedDate({required this.focusedDate});

  @override
  List<Object?> get props => [focusedDate];
}

class UpdateSelectedDate extends CalendarEvent with EquatableMixin {
  final DateTime selectedDate;

  const UpdateSelectedDate({required this.selectedDate});

  @override
  List<Object?> get props => [selectedDate];
}

class UpdateTitleCalendar extends CalendarEvent with EquatableMixin {
  final String titleCalendar;

  const UpdateTitleCalendar({required this.titleCalendar});

  @override
  List<Object?> get props => [titleCalendar];
}

class FilterTransactionsByDay extends CalendarEvent with EquatableMixin {
  final DateTime selectedDay;

  FilterTransactionsByDay(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}
