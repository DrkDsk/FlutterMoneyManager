import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';

class TopFiveSummary {
  List<StatBreakdown> expenseStats;

  TopFiveSummary({required this.expenseStats});

  TopFiveSummary copyWith({
    List<StatBreakdown>? expenseStats,
  }) {
    return TopFiveSummary(
      expenseStats: expenseStats ?? this.expenseStats,
    );
  }

  factory TopFiveSummary.initial() {
    return TopFiveSummary(expenseStats: []);
  }
}
