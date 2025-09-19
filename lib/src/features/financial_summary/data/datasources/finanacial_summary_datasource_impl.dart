import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/hive/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/yearly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
import 'package:hive/hive.dart';

class FinancialSummaryDatasourceImpl implements FinancialSummaryDatasource {
  final Box<FinancialSummaryHiveModel> _globalBalanceBox;
  final Box<YearlyFinancialSummaryHiveModel> _yearBalanceBox;

  const FinancialSummaryDatasourceImpl(
      {required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<FinancialSummaryHiveModel> globalBalanceBox,
      required Box<YearlyFinancialSummaryHiveModel> yearBalanceBox,
      required Box<YearlyTransactionsHiveModel> transactionsYearBox})
      : _globalBalanceBox = globalBalanceBox,
        _yearBalanceBox = yearBalanceBox;

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
  Future<FinancialSummaryModel?> getGlobalFinancialSummary(
      {required String key}) async {
    final hiveModel = _globalBalanceBox.get(key);

    if (hiveModel == null) return null;

    return FinancialSummaryModel.fromHive(hiveModel);
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
