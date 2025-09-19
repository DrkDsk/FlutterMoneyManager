import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryDatasource _datasource;

  const FinancialSummaryRepositoryImpl(
      {required FinancialSummaryDatasource datasource})
      : _datasource = datasource;

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final globalTransactionBalanceModel = await _datasource
            .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
        FinancialSummaryModel.initial();

    return globalTransactionBalanceModel.toEntity();
  }

  @override
  Future<void> saveYearFinancialSummary(
      {required Transaction transaction}) async {
    final date = transaction.transactionDate;
    final year = date.year;
    final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

    YearlyFinancialSummaryModel yearlyFinancialSummaryCurrentModel =
        await _datasource.getBalancesByYear(key: yearlyBalanceKey) ??
            YearlyFinancialSummaryModel.initial(year: year);

    final updatedYearlyFinancialSummary =
        FinancialCalculatorService.updateYearlyFinancialSummary(
            transaction: transaction,
            yearlyFinancialSummary:
                yearlyFinancialSummaryCurrentModel.toEntity());

    yearlyFinancialSummaryCurrentModel =
        YearlyFinancialSummaryModel.fromEntity(updatedYearlyFinancialSummary);

    await _datasource.saveYearFinancialSummary(
        model: yearlyFinancialSummaryCurrentModel, key: yearlyBalanceKey);
  }

  @override
  Future<void> saveFinancialSummary({required Transaction transaction}) async {
    FinancialSummaryModel financialSummaryModel = await _datasource
            .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
        FinancialSummaryModel.initial();

    final updatedGlobalFinancial =
        FinancialCalculatorService.updateGlobalSummary(
            transaction: transaction,
            financialSummary: financialSummaryModel.toEntity());

    financialSummaryModel =
        FinancialSummaryModel.fromEntity(updatedGlobalFinancial);

    await _datasource.saveFinancialSummary(
        model: financialSummaryModel, key: HiveConstants.globalSummaryKey);
  }
}
