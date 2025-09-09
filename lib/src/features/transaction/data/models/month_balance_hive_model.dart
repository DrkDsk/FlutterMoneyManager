import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:hive/hive.dart';

part 'month_balance_hive_model.g.dart';

@HiveType(typeId: 3)
class MonthBalanceHiveModel extends HiveObject {
  @HiveField(0)
  final int month;

  @HiveField(1)
  final GlobalBalanceHiveModel balance;

  MonthBalanceHiveModel({
    required this.month,
    required this.balance,
  });

  MonthBalanceHiveModel copyWith({
    int? month,
    GlobalBalanceHiveModel? balance,
  }) {
    return MonthBalanceHiveModel(
      month: month ?? this.month,
      balance: balance ?? this.balance,
    );
  }
}
