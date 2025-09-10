import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';

class MonthlyFinancialSummary {
  final int month;

  final FinancialSummary summary;

  const MonthlyFinancialSummary({required this.month, required this.summary});
}
