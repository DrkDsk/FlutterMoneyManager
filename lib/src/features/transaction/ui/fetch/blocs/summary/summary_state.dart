import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

class SummaryState {
  final MonthlySummary lastMonthlySummary;
  final MonthlySummary currentMonthlySummary;

  const SummaryState(
      {required this.lastMonthlySummary, required this.currentMonthlySummary});

  SummaryState copyWith({
    MonthlySummary? lastMonthlySummary,
    MonthlySummary? currentMonthlySummary,
  }) {
    return SummaryState(
      lastMonthlySummary: lastMonthlySummary ?? this.lastMonthlySummary,
      currentMonthlySummary:
          currentMonthlySummary ?? this.currentMonthlySummary,
    );
  }

  factory SummaryState.initial() {
    return SummaryState(
        lastMonthlySummary: MonthlySummary.initial(),
        currentMonthlySummary: MonthlySummary.initial());
  }
}
