import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

enum SummaryTypeStatus { initial, loading, error, success }

class SummaryState {
  final MonthlySummary lastMonthlySummary;
  final MonthlySummary currentMonthlySummary;
  final String message;
  final SummaryTypeStatus status;

  const SummaryState(
      {required this.lastMonthlySummary,
      required this.currentMonthlySummary,
      this.message = "",
      this.status = SummaryTypeStatus.initial});

  SummaryState copyWith({
    MonthlySummary? lastMonthlySummary,
    MonthlySummary? currentMonthlySummary,
    String? message,
    SummaryTypeStatus? status,
  }) {
    return SummaryState(
      message: message ?? this.message,
      status: status ?? this.status,
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
