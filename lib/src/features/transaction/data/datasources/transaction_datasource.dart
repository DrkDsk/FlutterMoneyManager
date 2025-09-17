import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_transactions_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';

abstract interface class TransactionDatasource {
  Future<bool> save({required YearlyTransactionsDto dto, required String key});

  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<FinancialSummaryModel?> getGlobalFinancialSummary(
      {required String key});

  Future<YearlyFinancialSummaryModel?> getBalancesByYear({required String key});

  Future<YearlyTransactionsModel?> getYearlyTransactions({required String key});

  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryModel model, required String key});

  Future<bool> saveFinancialSummary(
      {required FinancialSummaryModel model, required String key});
}
