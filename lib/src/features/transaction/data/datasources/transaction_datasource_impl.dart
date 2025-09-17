import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
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
      {required YearlyTransactionsModel model, required String key}) async {
    try {
      final hiveModel = YearlyTransactionsHiveModel.fromModel(model);
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
  Future<FinancialSummaryModel?> getGlobalFinancialSummary(
      {required String key}) async {
    final hiveModel = _globalBalanceBox.get(key);

    if (hiveModel == null) return null;

    return FinancialSummaryModel.fromHive(hiveModel);
  }

  @override
  Future<YearlyFinancialSummaryModel?> getBalancesByYear(
      {required String key}) async {
    final hiveModel = _yearBalanceBox.get(key);

    if (hiveModel == null) {
      return null;
    }

    return YearlyFinancialSummaryModel.fromHive(hiveModel);
  }

  @override
  Future<YearlyTransactionsModel?> getYearlyTransactions(
      {required String key}) async {
    final hiveModel = _transactionsYearBox.get(key);

    if (hiveModel == null) {
      return null;
    }

    final model = YearlyTransactionsModel.fromHive(hiveModel);

    return model;
  }

  @override
  Future<bool> saveYearFinancialSummary(
      {required YearlyFinancialSummaryModel model, required String key}) async {
    final hiveModel = YearlyFinancialSummaryHiveModel.fromModel(model);
    _yearBalanceBox.put(key, hiveModel);

    return true;
  }

  @override
  Future<bool> saveFinancialSummary(
      {required FinancialSummaryModel model, required String key}) async {
    final hiveModel = FinancialSummaryHiveModel.fromModel(model);

    await _globalBalanceBox.put(
      key,
      hiveModel,
    );

    return true;
  }
}
