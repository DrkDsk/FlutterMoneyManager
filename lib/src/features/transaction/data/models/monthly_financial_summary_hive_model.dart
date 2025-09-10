import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_financial_summary.dart';
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

  MonthlyFinancialSummary toEntity() {
    return MonthlyFinancialSummary(month: month, summary: summary.toEntity());
  }

  factory MonthlyFinancialSummaryHiveModel.fromEntity(
      MonthlyFinancialSummary entity) {
    return MonthlyFinancialSummaryHiveModel(
        month: entity.month,
        summary: FinancialSummaryHiveModel.fromEntity(entity.summary));
  }
}
