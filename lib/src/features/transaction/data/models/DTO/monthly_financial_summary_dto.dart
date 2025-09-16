import 'package:flutter_money_manager/src/core/shared/hive/data/DTO/financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_financial_summary_hive_model.dart';

class MonthlyFinancialSummaryDto {
  final int month;

  final FinancialSummaryDto summary;

  const MonthlyFinancialSummaryDto(
      {required this.month, required this.summary});

  factory MonthlyFinancialSummaryDto.fromHive(
      MonthlyFinancialSummaryHiveModel hive) {
    return MonthlyFinancialSummaryDto(
        month: hive.month, summary: FinancialSummaryDto.fromHive(hive.summary));
  }

  MonthlyFinancialSummaryModel toModel() {
    return MonthlyFinancialSummaryModel(
        month: month, summary: summary.toModel());
  }

  factory MonthlyFinancialSummaryDto.fromModel(
      MonthlyFinancialSummaryModel model) {
    return MonthlyFinancialSummaryDto(
        month: model.month,
        summary: FinancialSummaryDto.fromModel(model.summary));
  }
}
