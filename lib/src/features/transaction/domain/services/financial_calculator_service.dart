import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

final class FinancialCalculatorService {
  static Map<String, int> calculateUpdatedSources(
      {required Map<String, int> balancesBySource,
      required String source,
      required bool isIncome,
      required int amount}) {
    final updatedSources = Map<String, int>.from(balancesBySource);
    final currentSourceBalance = updatedSources[source] ?? 0;
    updatedSources[source] =
        currentSourceBalance + (isIncome ? amount : -amount);
    return updatedSources;
  }

  static FinancialSummary calculateUpdatedSummary(
      {required FinancialSummary summary, required Transaction transaction}) {
    final isIncome = transaction.type == TransactionTypEnum.income;
    final source = transaction.sourceType ?? "Unknown";
    final amount = transaction.amount;

    final updatedSources = calculateUpdatedSources(
        balancesBySource: summary.balancesBySource,
        amount: amount,
        source: source,
        isIncome: isIncome);

    final newIncome = summary.income + (isIncome ? amount : 0);
    final newExpense = summary.expense + (!isIncome ? amount : 0);
    final newTotal = summary.netWorth + (isIncome ? amount : -amount);

    final newAsset = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kPositiveTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? 0 : e.value));

    final newDebt = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kNegativeTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? -e.value : e.value));

    return summary.copyWith(
      income: newIncome,
      expense: newExpense,
      netWorth: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );
  }

  static FinancialSummary getGlobalFinancialSummary(
      {required List<Transaction> transactions}) {
    int income = 0;
    int expense = 0;
    int netWorth = 0;
    final Map<String, int> balancesBySource = {};

    for (final t in transactions) {
      final source = t.sourceType;
      if (source == null) continue;

      final int delta = t.type == TransactionTypEnum.income
          ? t.amount.abs()
          : -t.amount.abs();

      balancesBySource[source] = (balancesBySource[source] ?? 0) + delta;

      if (delta >= 0) {
        income += delta;
      } else {
        expense += -delta;
      }
      netWorth += delta;
    }

    int asset = 0;
    int debt = 0;

    for (final entry in balancesBySource.entries) {
      final balance = entry.value;
      if (TransactionsConstants.kPositiveTransactionSources
          .contains(entry.key)) {
        asset += balance > 0 ? balance : 0;
      } else if (TransactionsConstants.kNegativeTransactionSources
          .contains(entry.key)) {
        debt += balance < 0 ? -balance : 0;
      }
    }
    return FinancialSummary(
        income: income,
        expense: expense,
        asset: asset,
        netWorth: netWorth,
        debt: debt,
        balancesBySource: balancesBySource);
  }

  static FinancialSummary updateGlobalSummary(
      {required Transaction transaction, FinancialSummary? financialSummary}) {
    financialSummary = financialSummary ?? FinancialSummary.initial();

    final result = calculateUpdatedSummary(
        transaction: transaction, summary: financialSummary);

    return result;
  }
}
