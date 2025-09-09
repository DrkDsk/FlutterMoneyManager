import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';
import 'package:hive/hive.dart';

part 'global_balance_hive_model.g.dart';

@HiveType(typeId: 2)
class GlobalBalanceHiveModel extends HiveObject {
  @HiveField(0)
  final int income;

  @HiveField(1)
  final int expense;

  @HiveField(2)
  final int total;

  @HiveField(3)
  final int asset;

  @HiveField(4)
  final Map<String, int> balancesBySource;

  @HiveField(5)
  final int debt;

  GlobalBalanceHiveModel(
      {required this.income,
      required this.expense,
      required this.total,
      required this.asset,
      required this.balancesBySource,
      required this.debt});

  GlobalBalanceHiveModel copyWith({
    int? income,
    int? expense,
    int? total,
    int? asset,
    Map<String, int>? balancesBySource,
    int? debt,
  }) {
    return GlobalBalanceHiveModel(
        income: income ?? this.income,
        expense: expense ?? this.expense,
        total: total ?? this.total,
        asset: asset ?? this.asset,
        balancesBySource: balancesBySource ?? this.balancesBySource,
        debt: debt ?? this.debt);
  }

  factory GlobalBalanceHiveModel.fromEntity(GlobalBalance entity) {
    return GlobalBalanceHiveModel(
        income: entity.income,
        expense: entity.expense,
        total: entity.total,
        asset: entity.asset,
        balancesBySource: entity.balancesBySource,
        debt: entity.debt);
  }

  factory GlobalBalanceHiveModel.initial() {
    return GlobalBalanceHiveModel(
        income: 0,
        expense: 0,
        total: 0,
        asset: 0,
        debt: 0,
        balancesBySource: {});
  }

  GlobalBalance toEntity() {
    return GlobalBalance(
        income: income,
        expense: expense,
        asset: asset,
        total: total,
        debt: debt,
        balancesBySource: balancesBySource);
  }
}
