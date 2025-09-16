import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_model.dart';

class YearlyFinancialSummaryModel {
  final int year;

  final List<MonthlyFinancialSummaryModel> months;

  const YearlyFinancialSummaryModel({required this.year, required this.months});

  factory YearlyFinancialSummaryModel.initial({required int year}) {
    return YearlyFinancialSummaryModel(year: year, months: []);
  }
}
