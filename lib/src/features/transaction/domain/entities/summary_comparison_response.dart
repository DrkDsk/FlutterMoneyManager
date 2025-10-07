import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

class SummaryComparisonResponse {
  final MonthlySummary lastMonthlySummary;
  final MonthlySummary currentMonthlySummary;

  const SummaryComparisonResponse(
      {required this.currentMonthlySummary, required this.lastMonthlySummary});
}
