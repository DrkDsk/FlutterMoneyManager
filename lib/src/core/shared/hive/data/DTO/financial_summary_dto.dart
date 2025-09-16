import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';

class FinancialSummaryDto {
  final int income;

  final int expense;

  final int netWorth;

  final int asset;

  final Map<String, int> balancesBySource;

  final int debt;

  const FinancialSummaryDto(
      {required this.income,
      required this.expense,
      required this.netWorth,
      required this.asset,
      required this.debt,
      required this.balancesBySource});

  FinancialSummaryModel toModel() {
    return FinancialSummaryModel(
        income: income,
        expense: expense,
        netWorth: netWorth,
        asset: asset,
        debt: debt,
        balancesBySource: balancesBySource);
  }

  factory FinancialSummaryDto.fromModel(FinancialSummaryModel model) {
    return FinancialSummaryDto(
        income: model.income,
        expense: model.expense,
        netWorth: model.netWorth,
        asset: model.asset,
        debt: model.debt,
        balancesBySource: model.balancesBySource);
  }

  FinancialSummaryDto copyWith({
    int? income,
    int? expense,
    int? netWorth,
    int? asset,
    Map<String, int>? balancesBySource,
    int? debt,
  }) {
    return FinancialSummaryDto(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      netWorth: netWorth ?? this.netWorth,
      asset: asset ?? this.asset,
      balancesBySource: balancesBySource ?? this.balancesBySource,
      debt: debt ?? this.debt,
    );
  }

  factory FinancialSummaryDto.initial() {
    return const FinancialSummaryDto(
        income: 0,
        expense: 0,
        netWorth: 0,
        asset: 0,
        debt: 0,
        balancesBySource: {});
  }

  factory FinancialSummaryDto.fromHive(FinancialSummaryHiveModel hive) {
    return FinancialSummaryDto(
        income: hive.income,
        expense: hive.expense,
        netWorth: hive.netWorth,
        asset: hive.asset,
        debt: hive.debt,
        balancesBySource: hive.balancesBySource);
  }
}
