import 'package:flutter_money_manager/src/core/shared/hive/data/DTO/financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/monthly_financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';

class YearlyFinancialSummaryDto {
  final int year;

  final List<MonthlyFinancialSummaryDto> months;

  const YearlyFinancialSummaryDto({required this.year, required this.months});

  /*factory YearlyFinancialSummaryDto.fromHive(
      YearlyFinancialSummaryHiveModel hive) {
    return YearlyFinancialSummaryDto(
        year: hive.year,
        months: hive.months
            .map((hive) => MonthlyFinancialSummaryDto.fromHive(hive))
            .toList());
  }*/

  Map<int, FinancialSummaryDto> toEntityMap() {
    return Map.fromEntries(
      months.map((e) => MapEntry(e.month, e.summary)),
    );
  }

  YearlyFinancialSummaryModel toModel() {
    return YearlyFinancialSummaryModel(
        year: year,
        months: months.map((element) => element.toModel()).toList());
  }

  factory YearlyFinancialSummaryDto.fromModel(
      YearlyFinancialSummaryModel model) {
    return YearlyFinancialSummaryDto(
        year: model.year,
        months: model.months
            .map((model) => MonthlyFinancialSummaryDto.fromModel(model))
            .toList());
  }
}
