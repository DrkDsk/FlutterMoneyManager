import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';

abstract interface class FinancialSummaryDatasource {
  Future<FinancialSummaryModel?> getGlobalFinancialSummary(
      {required String key});

  Future<YearlyFinancialSummaryModel?> getSummaryByYear({required String key});

  Future<bool> saveFinancialSummary(
      {required FinancialSummaryModel model, required String key});

  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryModel model, required String key});
}
