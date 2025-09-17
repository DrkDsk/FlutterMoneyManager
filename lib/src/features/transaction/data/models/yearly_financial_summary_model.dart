import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_financial_summary.dart';

class YearlyFinancialSummaryModel {
  final int year;

  final List<MonthlyFinancialSummaryModel> months;

  const YearlyFinancialSummaryModel({required this.year, required this.months});

  factory YearlyFinancialSummaryModel.initial({required int year}) {
    return YearlyFinancialSummaryModel(year: year, months: []);
  }

  factory YearlyFinancialSummaryModel.fromHive(
      YearlyFinancialSummaryHiveModel hive) {
    return YearlyFinancialSummaryModel(
        year: hive.year,
        months: hive.months.map((monthlyFinancialSummaryHive) {
          return MonthlyFinancialSummaryModel.fromHive(
              monthlyFinancialSummaryHive);
        }).toList());
  }

  YearlyFinancialSummary toEntity() {
    return YearlyFinancialSummary(
        year: year,
        months: months.map((month) {
          return month.toEntity();
        }).toList());
  }

  factory YearlyFinancialSummaryModel.fromEntity(
      YearlyFinancialSummary entity) {
    return YearlyFinancialSummaryModel(
        year: entity.year,
        months: entity.months.map((month) {
          return MonthlyFinancialSummaryModel.fromEntity(month);
        }).toList());
  }
}
