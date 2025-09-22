import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class FinancialSummaryRepository {
  Future<FinancialSummary> getGlobalFinancialSummary();

  Future<void> saveFinancialSummary({required Transaction transaction});
}
