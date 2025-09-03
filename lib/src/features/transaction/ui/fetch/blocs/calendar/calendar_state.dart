import 'package:equatable/equatable.dart';

class CalendarState with EquatableMixin {
  final DateTime focusedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;

  const CalendarState(
      {required this.focusedDate,
      required this.firstDate,
      required this.lastDate,
      required this.selectedDate});

  @override
  List<Object> get props => [focusedDate, firstDate, lastDate, selectedDate];

  factory CalendarState.initial() {
    final defaulDate = DateTime.now();

    final firstDay = defaulDate.subtract(const Duration(days: 300));
    final lastDay = defaulDate.add(const Duration(days: 1080));

    return CalendarState(
        focusedDate: defaulDate,
        firstDate: firstDay,
        lastDate: lastDay,
        selectedDate: defaulDate);
  }

  CalendarState copyWith({
    DateTime? focusedDate,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? selectedDate,
  }) {
    return CalendarState(
      focusedDate: focusedDate ?? this.focusedDate,
      firstDate: firstDate ?? this.firstDate,
      lastDate: lastDate ?? this.lastDate,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
