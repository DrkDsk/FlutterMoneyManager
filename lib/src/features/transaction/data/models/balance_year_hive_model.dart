import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/month_balance_hive_model.dart';
import 'package:hive/hive.dart';

part 'balance_year_hive_model.g.dart';

@HiveType(typeId: 4)
class BalanceYearHiveModel extends HiveObject {
  @HiveField(0)
  final int year;

  @HiveField(1)
  final List<MonthBalanceHiveModel> months;

  BalanceYearHiveModel({
    required this.year,
    required this.months,
  });

  Map<int, GlobalBalance> toEntityMap() {
    return Map.fromEntries(
      months.map((e) => MapEntry(e.month, e.balance.toEntity())),
    );
  }

  GlobalBalanceHiveModel? getByMonth(int month) {
    return months
        .firstWhere((m) => m.month == month,
            orElse: () => MonthBalanceHiveModel(
                month: month,
                balance: GlobalBalanceHiveModel(
                    balancesBySource: {},
                    debt: 0,
                    asset: 0,
                    total: 0,
                    expense: 0,
                    income: 0)))
        .balance;
  }

  BalanceYearHiveModel copyWith({
    int? year,
    List<MonthBalanceHiveModel>? months,
  }) {
    return BalanceYearHiveModel(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }
}
