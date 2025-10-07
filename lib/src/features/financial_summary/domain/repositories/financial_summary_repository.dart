import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/top_five_summary.dart';

abstract interface class FinancialSummaryRepository {
  Future<FinancialSummary> getGlobalFinancialSummary();

  Future<TopFiveSummary> getTopFiveSummary(
      {required int month, required int year});
}
