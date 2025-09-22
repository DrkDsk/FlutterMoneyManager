import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';

class FinancialSummaryService {
  final FinancialSummaryDatasource _financialSummaryDatasource;
  final TransactionDatasource _transactionDatasource;

  const FinancialSummaryService(
      {required FinancialSummaryDatasource datasource,
      required TransactionDatasource transactionDatasource})
      : _financialSummaryDatasource = datasource,
        _transactionDatasource = transactionDatasource;

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

  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final transactionsModels =
        await _transactionDatasource.getAllTransactions();

    final transactions =
        transactionsModels.map((model) => model.toEntity()).toList();

    final updatedYearlyFinancialSummary =
        FinancialCalculatorService.getGlobalFinancialSummary(
            transactions: transactions);

    return updatedYearlyFinancialSummary;
  }
}
