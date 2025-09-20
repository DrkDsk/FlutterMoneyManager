import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';

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

  Future<void> saveYearFinancialSummary(
      {required Transaction transaction}) async {
    final date = transaction.transactionDate;
    final year = date.year;
    final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

    YearlyFinancialSummaryModel yearlyFinancialSummaryCurrentModel =
        await _financialSummaryDatasource.getSummaryByYear(
                key: yearlyBalanceKey) ??
            YearlyFinancialSummaryModel.initial(year: year);

    final updatedYearlyFinancialSummary =
        FinancialCalculatorService.updateYearlyFinancialSummary(
            transaction: transaction,
            yearlyFinancialSummary:
                yearlyFinancialSummaryCurrentModel.toEntity());

    yearlyFinancialSummaryCurrentModel =
        YearlyFinancialSummaryModel.fromEntity(updatedYearlyFinancialSummary);

    await _financialSummaryDatasource.saveYearFinancialSummary(
        model: yearlyFinancialSummaryCurrentModel, key: yearlyBalanceKey);
  }

  Future<void> saveFinancialSummary({required Transaction transaction}) async {
    FinancialSummaryModel financialSummaryModel =
        await _financialSummaryDatasource.getGlobalFinancialSummary(
                key: HiveConstants.globalSummaryKey) ??
            FinancialSummaryModel.initial();

    final updatedGlobalFinancial =
        FinancialCalculatorService.updateGlobalSummary(
            transaction: transaction,
            financialSummary: financialSummaryModel.toEntity());

    financialSummaryModel =
        FinancialSummaryModel.fromEntity(updatedGlobalFinancial);

    await _financialSummaryDatasource.saveFinancialSummary(
        model: financialSummaryModel, key: HiveConstants.globalSummaryKey);
  }
}
