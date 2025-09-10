import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_financial_summary.dart';

class YearlyFinancialSummary {
  final int year;

  final List<MonthlyFinancialSummary> months;

  const YearlyFinancialSummary({required this.year, required this.months});

  factory YearlyFinancialSummary.initial({required int year}) {
    return YearlyFinancialSummary(year: year, months: []);
  }

  Map<int, FinancialSummary> toEntityMap() {
    return Map.fromEntries(
      months.map((e) => MapEntry(e.month, e.summary)),
    );
  }
}
