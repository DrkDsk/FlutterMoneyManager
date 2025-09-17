import 'package:flutter_money_manager/src/features/transaction/data/models/hive/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
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

  factory YearlyFinancialSummaryHiveModel.initial({required int year}) {
    return YearlyFinancialSummaryHiveModel(year: year, months: []);
  }

  factory YearlyFinancialSummaryHiveModel.fromModel(
      YearlyFinancialSummaryModel model) {
    return YearlyFinancialSummaryHiveModel(
        year: model.year,
        months: model.months
            .map((model) => MonthlyFinancialSummaryHiveModel.fromModel(model))
            .toList());
  }
}
