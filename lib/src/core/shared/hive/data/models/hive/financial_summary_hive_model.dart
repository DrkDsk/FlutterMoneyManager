import 'package:flutter_money_manager/src/core/shared/hive/data/DTO/financial_summary_dto.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
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

/*factory FinancialSummaryHiveModel.fromEntity(FinancialSummary entity) {
    return FinancialSummaryHiveModel(
        income: entity.income,
        expense: entity.expense,
        netWorth: entity.netWorth,
        asset: entity.asset,
        balancesBySource: entity.balancesBySource,
        debt: entity.debt);
  }

  factory FinancialSummaryHiveModel.initial() {
    return FinancialSummaryHiveModel(
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
  }*/

  FinancialSummaryDto toDTO() {
    return FinancialSummaryDto(
        income: income,
        expense: expense,
        netWorth: netWorth,
        asset: asset,
        debt: debt,
        balancesBySource: balancesBySource);
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
