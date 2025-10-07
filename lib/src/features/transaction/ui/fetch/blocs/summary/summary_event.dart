sealed class SummaryEvent {
  const SummaryEvent();
}

class FetchSummaryEvent extends SummaryEvent {
  final int currentMonthIndex;

  const FetchSummaryEvent({required this.currentMonthIndex});
}
