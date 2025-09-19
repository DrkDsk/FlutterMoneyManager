import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

class TransactionService {
  final TransactionDatasource _transactionDatasource;
  final FinancialSummaryDatasource _financialSummaryDatasource;

  TransactionService(
      {required TransactionDatasource transactionDatasource,
      required FinancialSummaryDatasource financialSummaryDatasource})
      : _transactionDatasource = transactionDatasource,
        _financialSummaryDatasource = financialSummaryDatasource;

  Future<Map<String, List<TransactionModel>>?> getTransactionsMonth(
      {required int month, required int year}) async {
    final yearlyTransactionsKey =
        HiveHelper.generateYearlyTransactionKey(year: year);

    final yearlyTransactions = await _transactionDatasource
        .getYearlyTransactions(key: yearlyTransactionsKey);

    final monthTransactions = yearlyTransactions?.months
        .where((monthTransaction) => monthTransaction.month == month)
        .toList();

    if (monthTransactions == null || monthTransactions.isEmpty) {
      return null;
    }

    return monthTransactions.first.transactions;
  }

  Future<FinancialSummaryModel?> getBalanceByMonth(
      {required String key, required int month}) async {
    final yearlyBalances =
        await _financialSummaryDatasource.getBalancesByYear(key: key);

    if (yearlyBalances == null) {
      return null;
    }

    final balances = yearlyBalances.months
        .where((monthBalance) => monthBalance.month == month)
        .toList();

    if (balances.isEmpty) {
      return null;
    }

    return balances.first.summary;
  }
}
