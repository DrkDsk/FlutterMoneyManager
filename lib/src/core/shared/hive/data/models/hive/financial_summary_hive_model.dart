import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:hive/hive.dart';

part 'financial_summary_hive_model.g.dart';

@HiveType(typeId: 2)
class FinancialSummaryHiveModel extends HiveObject {
  @HiveField(0)
  final int income;

  @HiveField(1)
  final int expense;

  @HiveField(2)
  final int netWorth;

  @HiveField(3)
  final int asset;

  @HiveField(4)
  final Map<String, int> balancesBySource;

  @HiveField(5)
  final int debt;

  FinancialSummaryHiveModel(
      {required this.income,
      required this.expense,
      required this.netWorth,
      required this.asset,
      required this.balancesBySource,
      required this.debt});

  FinancialSummaryHiveModel copyWith({
    int? income,
    int? expense,
    int? netWorth,
    int? asset,
    Map<String, int>? balancesBySource,
    int? debt,
  }) {
    return FinancialSummaryHiveModel(
        income: income ?? this.income,
        expense: expense ?? this.expense,
        netWorth: netWorth ?? this.netWorth,
        asset: asset ?? this.asset,
        balancesBySource: balancesBySource ?? this.balancesBySource,
        debt: debt ?? this.debt);
  }

  factory FinancialSummaryHiveModel.fromModel(FinancialSummaryModel model) {
    return FinancialSummaryHiveModel(
        income: model.income,
        expense: model.expense,
        netWorth: model.netWorth,
        asset: model.asset,
        balancesBySource: model.balancesBySource,
        debt: model.debt);
  }
}
