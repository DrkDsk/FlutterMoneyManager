import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

class CalendarState with EquatableMixin {
  final DateTime focusedDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final DateTime selectedDate;
  final String titleCalendar;
  final List<TransactionsData> transactions;
  final String message;

  const CalendarState(
      {required this.focusedDate,
      required this.firstDate,
      required this.lastDate,
      required this.titleCalendar,
      this.message = "",
      this.transactions = const [],
      required this.selectedDate});

  @override
  List<Object> get props => [
        focusedDate,
        firstDate,
        lastDate,
        selectedDate,
        titleCalendar,
        transactions,
        message
      ];

  factory CalendarState.initial() {
    final defaultDate = DateTime.now();

    final firstDay = defaultDate.subtract(const Duration(days: 300));
    final lastDay = defaultDate.add(const Duration(days: 1080));

    final titleDateFormatted = "${defaultDate.monthName} ${defaultDate.year}";

    return CalendarState(
        focusedDate: defaultDate,
        firstDate: firstDay,
        lastDate: lastDay,
        selectedDate: defaultDate,
        titleCalendar: titleDateFormatted);
  }

  CalendarState copyWith(
      {DateTime? focusedDate,
      DateTime? firstDate,
      DateTime? lastDate,
      DateTime? selectedDate,
      String? titleCalendar,
      List<TransactionsData>? transactions,
      String? message}) {
    return CalendarState(
        focusedDate: focusedDate ?? this.focusedDate,
        firstDate: firstDate ?? this.firstDate,
        lastDate: lastDate ?? this.lastDate,
        selectedDate: selectedDate ?? this.selectedDate,
        titleCalendar: titleCalendar ?? this.titleCalendar,
        transactions: transactions ?? this.transactions,
        message: message ?? this.message);
  }
}
