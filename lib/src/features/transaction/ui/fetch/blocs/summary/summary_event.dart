import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

sealed class SummaryEvent {
  const SummaryEvent();
}

class FetchSummaryEvent extends SummaryEvent {
  final int previousMonthIndex;

  const FetchSummaryEvent({required this.previousMonthIndex});
}

class FetchTopFiveExpense extends SummaryEvent {
  const FetchTopFiveExpense();
}

class UpdateSelectedDate extends SummaryEvent {
  final int year;
  final int month;

  const UpdateSelectedDate({required this.year, required this.month});
}

class UpdateTopFiveType extends SummaryEvent {
  final TransactionTypEnum type;

  const UpdateTopFiveType({required this.type});
}
