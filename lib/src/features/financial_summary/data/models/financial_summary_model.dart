import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';

class FinancialSummaryModel {
  final int income;
  final int expense;
  final int netWorth;
  final int asset;
  final Map<String, int> balancesBySource;
  final int debt;

  const FinancialSummaryModel(
      {required this.income,
      required this.expense,
      required this.netWorth,
      required this.asset,
      required this.debt,
      required this.balancesBySource});

  factory FinancialSummaryModel.fromEntity(FinancialSummary entity) {
    return FinancialSummaryModel(
        income: entity.income,
        expense: entity.expense,
        netWorth: entity.netWorth,
        asset: entity.asset,
        balancesBySource: entity.balancesBySource,
        debt: entity.debt);
  }
}
