import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryService _financialSummaryService;

  const FinancialSummaryRepositoryImpl(
      {required FinancialSummaryService financialSummaryService})
      : _financialSummaryService = financialSummaryService;

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final updatedSummary =
        await _financialSummaryService.getGlobalFinancialSummary();

    return updatedSummary;
  }

  @override
  Future<void> saveFinancialSummary({required Transaction transaction}) async {
    await _financialSummaryService.saveFinancialSummary(
        transaction: transaction);
  }
}
