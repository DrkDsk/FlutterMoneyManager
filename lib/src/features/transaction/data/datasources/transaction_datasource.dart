import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionDatasource {
  Future<bool> saveTransaction(Transaction transaction);

  Future<Map<String, List<TransactionHiveModel>>> getTransactionsModelsMonth(
      {required int month, required int year});

  Future<List<TransactionHiveModel>> getTransactionsModelsByDate(
      {required DateTime date});

  Future<List<TransactionSourceHiveModel>> getTransactionSources();

  Future<FinancialSummaryHiveModel> getGlobalFinancialSummary();

  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear({int? year});

  Future<FinancialSummaryHiveModel> getBalancesMonth(
      {required int month, required int year});
}
