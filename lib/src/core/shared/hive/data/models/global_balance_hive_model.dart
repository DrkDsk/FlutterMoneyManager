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

  GlobalBalanceHiveModel({
    required this.income,
    required this.expense,
    required this.total,
    required this.asset,
    required this.balancesBySource,
  });

  GlobalBalanceHiveModel copyWith({
    int? income,
    int? expense,
    int? total,
    int? asset,
    Map<String, int>? balancesBySource,
  }) {
    return GlobalBalanceHiveModel(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      total: total ?? this.total,
      asset: asset ?? this.asset,
      balancesBySource: balancesBySource ?? this.balancesBySource,
    );
  }

  factory GlobalBalanceHiveModel.fromEntity(GlobalBalance entity) {
    return GlobalBalanceHiveModel(
      income: entity.income,
      expense: entity.expense,
      total: entity.total,
      asset: entity.asset,
      balancesBySource: entity.balancesBySource,
    );
  }

  GlobalBalance toEntity() {
    return GlobalBalance(
        income: income,
        expense: expense,
        asset: asset,
        total: total,
        balancesBySource: balancesBySource);
  }
}
