import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/top_five_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

enum SummaryTypeStatus { initial, loading, error, success }

class SummaryState {
  final MonthlySummary lastMonthlySummary;
  final MonthlySummary currentMonthlySummary;
  final TopFiveSummary topFiveSummary;
  final String message;
  final SummaryTypeStatus status;
  final int selectedYear;
  final int selectedMonth;
  final TransactionTypEnum selectedTypeForChart;

  const SummaryState(
      {required this.lastMonthlySummary,
      required this.currentMonthlySummary,
      required this.topFiveSummary,
      this.message = "",
      this.status = SummaryTypeStatus.initial,
      required this.selectedMonth,
      required this.selectedYear,
      this.selectedTypeForChart = TransactionTypEnum.expense});

  SummaryState copyWith(
      {MonthlySummary? lastMonthlySummary,
      MonthlySummary? currentMonthlySummary,
      String? message,
      SummaryTypeStatus? status,
      TopFiveSummary? topFiveSummary,
      TransactionTypEnum? selectedTypeForChart,
      int? selectedYear,
      int? selectedMonth}) {
    return SummaryState(
        message: message ?? this.message,
        status: status ?? this.status,
        selectedMonth: selectedMonth ?? this.selectedMonth,
        selectedYear: selectedYear ?? this.selectedYear,
        lastMonthlySummary: lastMonthlySummary ?? this.lastMonthlySummary,
        currentMonthlySummary:
            currentMonthlySummary ?? this.currentMonthlySummary,
        topFiveSummary: topFiveSummary ?? this.topFiveSummary,
        selectedTypeForChart:
            selectedTypeForChart ?? this.selectedTypeForChart);
  }

  factory SummaryState.initial() {
    return SummaryState(
        selectedYear: 0,
        selectedMonth: 0,
        lastMonthlySummary: MonthlySummary.initial(),
        currentMonthlySummary: MonthlySummary.initial(),
        topFiveSummary: TopFiveSummary.initial());
  }
}
