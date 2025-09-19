import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/data/datasources/financial_summary_datasource.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryDatasource _datasource;

  const FinancialSummaryRepositoryImpl(
      {required FinancialSummaryDatasource datasource})
      : _datasource = datasource;

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final globalTransactionBalanceModel = await _datasource
            .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
        FinancialSummaryModel.initial();

    return globalTransactionBalanceModel.toEntity();
  }
}
