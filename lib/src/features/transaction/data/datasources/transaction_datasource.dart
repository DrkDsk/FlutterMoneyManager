import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/balance_year_hive_model.dart';
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

  Future<GlobalBalanceHiveModel?> getGlobalBalance();

  Future<BalanceYearHiveModel?> getBalancesByYear({int? year});

  Future<GlobalBalanceHiveModel> getBalancesMonth(
      {required int month, required int year});
}
