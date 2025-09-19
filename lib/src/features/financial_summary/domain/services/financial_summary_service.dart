import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';

class FinancialSummaryService {
  final FinancialSummaryDatasource _financialSummaryDatasource;

  const FinancialSummaryService(
      {required FinancialSummaryDatasource datasource})
      : _financialSummaryDatasource = datasource;

  Future<FinancialSummaryModel?> getSummaryByMonth(
      {required String key, required int month}) async {
    final yearlySummaries =
        await _financialSummaryDatasource.getSummaryByYear(key: key);

    if (yearlySummaries == null) {
      return null;
    }

    final summaries = yearlySummaries.months
        .where((monthBalance) => monthBalance.month == month)
        .toList();

    if (summaries.isEmpty) {
      return null;
    }

    return summaries.first.summary;
  }
}
