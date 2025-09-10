import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class FinancialCalculatorService {
  final bool isIncome;
  final String source;
  final int amount;
  final Map<String, int> balancesBySource;

  const FinancialCalculatorService(
      {required this.isIncome,
      required this.source,
      required this.amount,
      required this.balancesBySource});

  Map<String, int> calculateUpdatedSources() {
    final updatedSources = Map<String, int>.from(balancesBySource);
    final currentSourceBalance = updatedSources[source] ?? 0;
    updatedSources[source] =
        currentSourceBalance + (isIncome ? amount : -amount);
    return updatedSources;
  }

  FinancialSummary calculateUpdatedSummary(FinancialSummary baseSummary) {
    final updatedSources = calculateUpdatedSources();

    final newIncome = baseSummary.income + (isIncome ? amount : 0);
    final newExpense = baseSummary.expense + (!isIncome ? amount : 0);
    final newTotal = baseSummary.netWorth + (isIncome ? amount : -amount);

    final newAsset = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kPositiveTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? 0 : e.value));

    final newDebt = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kNegativeTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? -e.value : e.value));

    return baseSummary.copyWith(
      income: newIncome,
      expense: newExpense,
      netWorth: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );
  }

  factory FinancialCalculatorService.fromTransaction(
      {required Transaction transaction,
      required Map<String, int> balancesBySource}) {
    final isIncome = transaction.type == TransactionTypEnum.income;
    final source = transaction.sourceType ?? "Unknown";
    final amount = transaction.amount;

    return FinancialCalculatorService(
        isIncome: isIncome,
        source: source,
        amount: amount,
        balancesBySource: balancesBySource);
  }
}
