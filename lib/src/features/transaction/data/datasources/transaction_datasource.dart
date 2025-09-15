import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_transactions_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';

abstract interface class TransactionDatasource {
  Future<bool> save({required YearlyTransactionsDto dto, required String key});

  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<FinancialSummaryHiveModel?> getGlobalFinancialSummary(
      {required String key});

  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear(
      {required String key});

  Future<YearlyTransactionsModel?> getYearlyTransactionsHiveModel(
      {required String key});

  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryHiveModel model, required String key});

  Future<bool> saveFinancialSummary(
      {required FinancialSummaryHiveModel model, required String key});
}
