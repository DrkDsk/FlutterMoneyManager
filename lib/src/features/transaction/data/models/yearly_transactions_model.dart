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

  factory YearlyTransactionsModel.fromEntity(YearlyTransactions entity) {
    return YearlyTransactionsModel(
        year: entity.year,
        months: entity.months
            .map((month) => MonthlyTransactionsModel.fromEntity(month))
            .toList());
  }
}
