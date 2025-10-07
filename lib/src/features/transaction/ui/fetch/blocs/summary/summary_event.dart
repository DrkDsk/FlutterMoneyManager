sealed class SummaryEvent {
  const SummaryEvent();
}

class FetchSummaryEvent extends SummaryEvent {
  final int previousMonthIndex;
  final int currentMonthIndex;
  final int year;

  const FetchSummaryEvent(
      {required this.currentMonthIndex,
      required this.previousMonthIndex,
      required this.year});
}
