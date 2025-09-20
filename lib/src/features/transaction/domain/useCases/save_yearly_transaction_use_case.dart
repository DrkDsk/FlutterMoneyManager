import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class SaveYearlyTransactionUseCase {
  final TransactionRepository _transactionRepository;
  final FinancialSummaryRepository _financialSummaryRepository;

  const SaveYearlyTransactionUseCase(
      {required TransactionRepository transactionRepository,
      required FinancialSummaryRepository financialSummaryRepository})
      : _transactionRepository = transactionRepository,
        _financialSummaryRepository = financialSummaryRepository;

  Future<bool> call({required Transaction transaction}) async {
    try {
      final saveTransaction = _transactionRepository.save(transaction);
      final saveYearSummary = _financialSummaryRepository
          .saveYearFinancialSummary(transaction: transaction);
      final saveGlobalSummary = _financialSummaryRepository
          .saveFinancialSummary(transaction: transaction);

      await Future.wait([saveTransaction, saveYearSummary, saveGlobalSummary]);

      return true;
    } catch (e) {
      return false;
    }
  }
}
