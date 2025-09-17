import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/yearly_transactions.dart';

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

  FinancialSummary calculateUpdatedSummary(FinancialSummary summary) {
    final updatedSources = calculateUpdatedSources();

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

    final baseBalance = yearModelAsMap[month] ?? FinancialSummary.initial();

    final calculator = FinancialCalculatorService.fromTransaction(
        transaction: transaction,
        balancesBySource: baseBalance.balancesBySource);

    final updatedBalance = calculator.calculateUpdatedSummary(baseBalance);

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

  static YearlyTransactions updateYearlyTransactionHiveModel(
      {required YearlyTransactions? yearlyTransactions,
      required Transaction transaction}) {
    final date = transaction.transactionDate;
    final month = date.month;

    yearlyTransactions =
        yearlyTransactions ?? YearlyTransactions.initial(year: date.year);

    final dayKey = HiveHelper.generateTransactionDayKey(date: date);
    final monthIndex =
        yearlyTransactions.months.indexWhere((m) => m.month == month);

    MonthlyTransactions monthlyTransactionsDTO;

    if (monthIndex != -1) {
      monthlyTransactionsDTO = yearlyTransactions.months[monthIndex];
    } else {
      monthlyTransactionsDTO = MonthlyTransactions.initial(month: month);
      yearlyTransactions.months.add(monthlyTransactionsDTO);
    }

    final transactionsByDay = List<Transaction>.from(
      monthlyTransactionsDTO.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(transaction);

    monthlyTransactionsDTO = monthlyTransactionsDTO.copyWith(
      transactions: {
        ...monthlyTransactionsDTO.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      yearlyTransactions.months[monthIndex] = monthlyTransactionsDTO;
    } else {
      final lastIndex = yearlyTransactions.months.length - 1;
      yearlyTransactions.months[lastIndex] = monthlyTransactionsDTO;
    }

    return yearlyTransactions;
  }

  static FinancialSummary updateGlobalSummary(
      {required Transaction transaction, FinancialSummary? financialSummary}) {
    financialSummary = financialSummary ?? FinancialSummary.initial();

    final updatedGlobalSummary = FinancialCalculatorService.fromTransaction(
      transaction: transaction,
      balancesBySource: financialSummary.balancesBySource,
    ).calculateUpdatedSummary(financialSummary);

    return updatedGlobalSummary;
  }
}
