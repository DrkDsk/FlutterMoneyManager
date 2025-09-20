import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryDatasource _datasource;
  final FinancialSummaryService _financialSummaryService;

  const FinancialSummaryRepositoryImpl(
      {required FinancialSummaryDatasource datasource,
      required FinancialSummaryService financialSummaryService})
      : _datasource = datasource,
        _financialSummaryService = financialSummaryService;

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final globalTransactionBalanceModel = await _datasource
            .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
        FinancialSummaryModel.initial();

    return globalTransactionBalanceModel.toEntity();
  }

  @override
  Future<void> saveYearFinancialSummary(
      {required Transaction transaction}) async {
    await _financialSummaryService.saveYearFinancialSummary(
        transaction: transaction);
  }

  @override
  Future<void> saveFinancialSummary({required Transaction transaction}) async {
    await _financialSummaryService.saveFinancialSummary(
        transaction: transaction);
  }
}
