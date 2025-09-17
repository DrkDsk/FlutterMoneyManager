import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_transactions.dart';

class YearlyTransactionsModel {
  final int year;

  final List<MonthlyTransactionsModel> months;

  const YearlyTransactionsModel({required this.year, required this.months});

  YearlyTransactions toEntity() {
    return YearlyTransactions(
        year: year, months: months.map((month) => month.toEntity()).toList());
  }

  factory YearlyTransactionsModel.fromHive(YearlyTransactionsHiveModel hive) {
    return YearlyTransactionsModel(
        year: hive.year,
        months: hive.months.map((monthly) {
          return MonthlyTransactionsModel.fromHive(monthly);
        }).toList());
  }
}
