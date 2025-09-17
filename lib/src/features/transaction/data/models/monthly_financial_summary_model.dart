import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_financial_summary.dart';

class MonthlyFinancialSummaryModel {
  final int month;

  final FinancialSummaryModel summary;

  const MonthlyFinancialSummaryModel(
      {required this.month, required this.summary});

  MonthlyFinancialSummary toEntity() {
    return MonthlyFinancialSummary(month: month, summary: summary.toEntity());
  }

  factory MonthlyFinancialSummaryModel.fromHive(
      MonthlyFinancialSummaryHiveModel hive) {
    return MonthlyFinancialSummaryModel(
        month: hive.month,
        summary: FinancialSummaryModel.fromHive(hive.summary));
  }

  factory MonthlyFinancialSummaryModel.fromEntity(
      MonthlyFinancialSummary entity) {
    return MonthlyFinancialSummaryModel(
        month: entity.month,
        summary: FinancialSummaryModel.fromEntity(entity.summary));
  }
}
