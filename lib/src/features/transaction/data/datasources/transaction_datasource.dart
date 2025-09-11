import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_hive_model.dart';

abstract interface class TransactionDatasource {
  Future<bool> save(
      {required YearlyTransactionsHiveModel model, required String key});

  Future<List<TransactionHiveModel>> getTransactionsModelsByDate(
      {required DateTime date});

  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<FinancialSummaryHiveModel?> getGlobalFinancialSummary(
      {required String key});

  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear(
      {required String key});

  Future<FinancialSummaryHiveModel> getBalancesMonth(
      {required int month, required int year});

  Future<YearlyTransactionsHiveModel?> getYearlyTransactionsHiveModel(
      {required String key});

  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryHiveModel model, required String key});

  Future<bool> saveFinancialSummary(
      {required FinancialSummaryHiveModel model, required String key});
}
