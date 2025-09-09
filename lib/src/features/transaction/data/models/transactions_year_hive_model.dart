import 'package:flutter_money_manager/src/features/transaction/data/models/transactions_month_hive_model.dart';
import 'package:hive/hive.dart';

part 'transactions_year_hive_model.g.dart';

@HiveType(typeId: 6)
class TransactionsYearHiveModel extends HiveObject {
  @HiveField(0)
  final int year;

  @HiveField(1)
  final List<TransactionsMonthHiveModel> months;

  TransactionsYearHiveModel({required this.year, required this.months});

  TransactionsYearHiveModel copyWith({
    int? year,
    List<TransactionsMonthHiveModel>? months,
  }) {
    return TransactionsYearHiveModel(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }
}
