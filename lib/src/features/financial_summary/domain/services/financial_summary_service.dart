import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';

class FinancialSummaryService {
  final TransactionDatasource _transactionDatasource;

  const FinancialSummaryService(
      {required TransactionDatasource transactionDatasource})
      : _transactionDatasource = transactionDatasource;

  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final transactionsModels =
        await _transactionDatasource.getAllTransactions();

    final transactions =
        transactionsModels.map((model) => model.toEntity()).toList();

    final updatedYearlyFinancialSummary =
        FinancialCalculatorService.getFinancialSummary(
            transactions: transactions);

    return updatedYearlyFinancialSummary;
  }
}
