import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_transactions_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<FinancialSummaryHiveModel> _globalBalanceBox;
  final Box<YearlyFinancialSummaryHiveModel> _yearBalanceBox;
  final Box<YearlyTransactionsHiveModel> _transactionsYearBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<FinancialSummaryHiveModel> globalBalanceBox,
      required Box<YearlyFinancialSummaryHiveModel> yearBalanceBox,
      required Box<YearlyTransactionsHiveModel> transactionsYearBox})
      : _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceBox,
        _transactionsYearBox = transactionsYearBox,
        _yearBalanceBox = yearBalanceBox;

  @override
  Future<bool> save(
      {required YearlyTransactionsDto dto, required String key}) async {
    try {
      final hiveModel = YearlyTransactionsHiveModel.fromDto(dto);
      await _transactionsYearBox.put(key, hiveModel);

      return true;
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<FinancialSummaryHiveModel?> getGlobalFinancialSummary(
      {required String key}) async {
    return _globalBalanceBox.get(key);
  }

  @override
  Future<YearlyFinancialSummaryHiveModel?> getBalancesByYear(
      {required String key}) async {
    return _yearBalanceBox.get(key);
  }

  @override
  Future<YearlyTransactionsHiveModel?> getYearlyTransactionsHiveModel(
      {required String key}) async {
    return _transactionsYearBox.get(key);
  }

  @override
  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryHiveModel model,
      required String key}) async {
    await _yearBalanceBox.put(key, model);

    return true;
  }

  @override
  Future<bool> saveFinancialSummary(
      {required FinancialSummaryHiveModel model, required String key}) async {
    await _globalBalanceBox.put(
      key,
      model,
    );

    return true;
  }
}
