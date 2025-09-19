import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_financial_summary.dart';

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

  static YearlyFinancialSummary updateYearlyFinancialSummary(
      {required Transaction transaction,
      required YearlyFinancialSummary yearlyFinancialSummary}) {
    final date = transaction.transactionDate;
    final month = date.month;

    final yearModelAsMap = yearlyFinancialSummary.toEntityMap();

    final monthIndexOfCurrentTransaction =
        yearlyFinancialSummary.months.indexWhere((m) => m.month == month);

    final summary = yearModelAsMap[month] ?? FinancialSummary.initial();

    final updatedBalance =
        calculateUpdatedSummary(summary: summary, transaction: transaction);

    final monthBalance = MonthlyFinancialSummary(
      month: month,
      summary: updatedBalance,
    );

    if (monthIndexOfCurrentTransaction != -1) {
      yearlyFinancialSummary.months[monthIndexOfCurrentTransaction] =
          monthBalance;
    } else {
      yearlyFinancialSummary.months.add(monthBalance);
    }

    return yearlyFinancialSummary;
  }

  static FinancialSummary updateGlobalSummary(
      {required Transaction transaction, FinancialSummary? financialSummary}) {
    financialSummary = financialSummary ?? FinancialSummary.initial();

    final result = calculateUpdatedSummary(
        transaction: transaction, summary: financialSummary);

    return result;
  }
}
