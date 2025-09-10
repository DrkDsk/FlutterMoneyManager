import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_financial_summary.dart';
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

  Map<int, FinancialSummary> toEntityMap() {
    return Map.fromEntries(
      months.map((e) => MapEntry(e.month, e.summary.toEntity())),
    );
  }

  YearlyFinancialSummary toEntity() {
    return YearlyFinancialSummary(
        year: year, months: months.map((month) => month.toEntity()).toList());
  }

  factory YearlyFinancialSummaryHiveModel.fromEntity(
      YearlyFinancialSummary entity) {
    return YearlyFinancialSummaryHiveModel(
      year: entity.year,
      months: entity.months
          .map((month) => MonthlyFinancialSummaryHiveModel.fromEntity(month))
          .toList(),
    );
  }

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
}
