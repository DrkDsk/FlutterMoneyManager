import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_transactions.dart';
import 'package:hive/hive.dart';

part 'yearly_transactions_hive_model.g.dart';

@HiveType(typeId: 6)
class YearlyTransactionsHiveModel extends HiveObject {
  @HiveField(0)
  final int year;

  @HiveField(1)
  final List<MonthlyTransactionsHiveModel> months;

  YearlyTransactionsHiveModel({required this.year, required this.months});

  YearlyTransactionsHiveModel copyWith({
    int? year,
    List<MonthlyTransactionsHiveModel>? months,
  }) {
    return YearlyTransactionsHiveModel(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }

  YearlyTransactions toEntity() {
    return YearlyTransactions(
        year: year, months: months.map((month) => month.toEntity()).toList());
  }

  factory YearlyTransactionsHiveModel.initial({required int year}) {
    return YearlyTransactionsHiveModel(year: year, months: []);
  }

  factory YearlyTransactionsHiveModel.fromEntity(YearlyTransactions entity) {
    return YearlyTransactionsHiveModel(
        year: entity.year,
        months: entity.months
            .map((month) => MonthlyTransactionsHiveModel.fromEntity(month))
            .toList());
  }
}
