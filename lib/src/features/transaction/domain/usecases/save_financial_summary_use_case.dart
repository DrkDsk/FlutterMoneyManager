import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class SaveFinancialSummaryUseCase {
  final FinancialSummaryRepository _repository;

  const SaveFinancialSummaryUseCase(
      {required FinancialSummaryRepository repository})
      : _repository = repository;

  Future<void> call({required Transaction transaction}) {
    return _repository.saveFinancialSummary(transaction: transaction);
  }
}
