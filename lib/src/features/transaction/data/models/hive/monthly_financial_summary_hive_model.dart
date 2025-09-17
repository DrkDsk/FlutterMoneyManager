import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_model.dart';
import 'package:hive/hive.dart';

part 'monthly_financial_summary_hive_model.g.dart';

@HiveType(typeId: 3)
class MonthlyFinancialSummaryHiveModel extends HiveObject {
  @HiveField(0)
  final int month;

  @HiveField(1)
  final FinancialSummaryHiveModel summary;

  MonthlyFinancialSummaryHiveModel({
    required this.month,
    required this.summary,
  });

  MonthlyFinancialSummaryHiveModel copyWith({
    int? month,
    FinancialSummaryHiveModel? summary,
  }) {
    return MonthlyFinancialSummaryHiveModel(
      month: month ?? this.month,
      summary: summary ?? this.summary,
    );
  }

  factory MonthlyFinancialSummaryHiveModel.fromModel(
      MonthlyFinancialSummaryModel model) {
    return MonthlyFinancialSummaryHiveModel(
        month: model.month,
        summary: FinancialSummaryHiveModel.fromModel(model.summary));
  }
}
