import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';

abstract interface class FinancialSummaryRepository {
  Future<FinancialSummary> getGlobalFinancialSummary();
}
