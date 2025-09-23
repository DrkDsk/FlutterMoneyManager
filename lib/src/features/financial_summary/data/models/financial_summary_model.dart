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

  factory FinancialSummaryModel.initial() {
    return const FinancialSummaryModel(
        income: 0,
        expense: 0,
        netWorth: 0,
        asset: 0,
        debt: 0,
        balancesBySource: {});
  }

  FinancialSummary toEntity() {
    return FinancialSummary(
        income: income,
        expense: expense,
        asset: asset,
        netWorth: netWorth,
        debt: debt,
        balancesBySource: balancesBySource);
  }
}
