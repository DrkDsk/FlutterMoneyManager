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
    Map<String, int> balancesSource = {};

    for (final transaction in transactions) {
      final source = transaction.sourceType;
      if (source == null) continue;

      final amountBySource = balancesSource[source] ?? 0;
      final isDebt =
          TransactionsConstants.kNegativeTransactionSources.contains(source);

      if (isDebt) {
        if (balancesSource.isNotEmpty) {
          balancesSource[source] = amountBySource - transaction.amount;
        } else {
          balancesSource[source] = transaction.amount;
        }
      } else {
        balancesSource[source] = amountBySource + transaction.amount;
      }

      if (transaction.type == TransactionTypEnum.income) {
        income += transaction.amount;
        netWorth += transaction.amount;
      } else {
        final expenseAmount =
            transaction.amount < 0 ? -transaction.amount : transaction.amount;
        expense += expenseAmount;
        netWorth -= expenseAmount;
      }
    }

    int asset = 0;
    int debt = 0;

    for (final entry in balancesSource.entries) {
      if (TransactionsConstants.kPositiveTransactionSources
          .contains(entry.key)) {
        asset += entry.value;
      } else if (TransactionsConstants.kNegativeTransactionSources
          .contains(entry.key)) {
        debt += -entry.value;
      }
    }

    return FinancialSummary(
        income: income,
        expense: expense,
        asset: asset,
        netWorth: netWorth,
        debt: debt,
        balancesBySource: balancesSource);
  }

  static FinancialSummary updateGlobalSummary(
      {required Transaction transaction, FinancialSummary? financialSummary}) {
    financialSummary = financialSummary ?? FinancialSummary.initial();

    final result = calculateUpdatedSummary(
        transaction: transaction, summary: financialSummary);

    return result;
  }
}
