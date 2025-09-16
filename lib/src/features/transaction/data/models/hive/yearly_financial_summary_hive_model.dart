import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/monthly_financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_financial_summary_hive_model.dart';
import 'package:hive/hive.dart';

part 'yearly_financial_summary_hive_model.g.dart';

@HiveType(typeId: 4)
class YearlyFinancialSummaryHiveModel extends HiveObject {
  @HiveField(0)
  final int year;

  @HiveField(1)
  final List<MonthlyFinancialSummaryHiveModel> months;

  YearlyFinancialSummaryHiveModel({
    required this.year,
    required this.months,
  });

  /*YearlyFinancialSummary toEntity() {
    return YearlyFinancialSummary(
        year: year,
        months: months.map((month) {
          final dto = MonthlyFinancialSummaryDto.fromHive(month);
          return dto.toModel().toEntity();
        }).toList());
  }*/

  /*factory YearlyFinancialSummaryHiveModel.fromEntity(
      YearlyFinancialSummary entity) {
    return YearlyFinancialSummaryHiveModel(
      year: entity.year,
      months: entity.months
          .map((month) => MonthlyFinancialSummaryHiveModel.fromEntity(month))
          .toList(),
    );
  }*/

  factory YearlyFinancialSummaryHiveModel.initial({required int year}) {
    return YearlyFinancialSummaryHiveModel(year: year, months: []);
  }

  FinancialSummaryHiveModel? getByMonth(int month) {
    return months
        .firstWhere((m) => m.month == month,
            orElse: () => MonthlyFinancialSummaryHiveModel(
                month: month,
                summary: FinancialSummaryHiveModel(
                    balancesBySource: {},
                    debt: 0,
                    asset: 0,
                    netWorth: 0,
                    expense: 0,
                    income: 0)))
        .summary;
  }

  YearlyFinancialSummaryHiveModel copyWith({
    int? year,
    List<MonthlyFinancialSummaryHiveModel>? months,
  }) {
    return YearlyFinancialSummaryHiveModel(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }

  YearlyFinancialSummaryDto toDto() {
    return YearlyFinancialSummaryDto(
        year: year,
        months: months
            .map((monthlyFinancialSummaryHive) =>
                MonthlyFinancialSummaryDto.fromHive(
                    monthlyFinancialSummaryHive))
            .toList());
  }

  factory YearlyFinancialSummaryHiveModel.fromDto(
      YearlyFinancialSummaryDto dto) {
    return YearlyFinancialSummaryHiveModel(
        year: dto.year,
        months: dto.months
            .map((dtoElement) =>
                MonthlyFinancialSummaryHiveModel.fromDto(dtoElement))
            .toList());
  }
}
