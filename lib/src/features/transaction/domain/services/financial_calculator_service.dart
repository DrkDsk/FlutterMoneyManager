import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_hive_model.dart';
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

  static YearlyFinancialSummaryHiveModel updateYearlyFinancialSummary(
      {required Transaction transaction,
      YearlyFinancialSummaryHiveModel? yearlyCurrentModel}) {
    final date = transaction.transactionDate;
    final year = date.year;
    final month = date.month;

    yearlyCurrentModel = yearlyCurrentModel ??
        YearlyFinancialSummaryHiveModel(year: year, months: []);

    final yearModelAsMap = yearlyCurrentModel.toEntityMap();

    final monthIndexOfCurrentTransaction =
        yearlyCurrentModel.months.indexWhere((m) => m.month == month);

    final baseBalance =
        yearModelAsMap[month] ?? FinancialSummaryHiveModel.initial().toEntity();

    final calculator = FinancialCalculatorService.fromTransaction(
        transaction: transaction,
        balancesBySource: baseBalance.balancesBySource);

    final updatedBalance = calculator.calculateUpdatedSummary(baseBalance);

    final monthBalance = MonthlyFinancialSummaryHiveModel(
      month: month,
      summary: FinancialSummaryHiveModel.fromEntity(updatedBalance),
    );

    if (monthIndexOfCurrentTransaction != -1) {
      yearlyCurrentModel.months[monthIndexOfCurrentTransaction] = monthBalance;
    } else {
      yearlyCurrentModel.months.add(monthBalance);
    }

    return yearlyCurrentModel;
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

  static YearlyTransactionsHiveModel updateYearlyTransactionHiveModel(
      {required YearlyTransactionsHiveModel? transactionsYear,
      required Transaction transaction}) {
    final date = transaction.transactionDate;
    final month = date.month;

    transactionsYear = transactionsYear ??
        YearlyTransactionsHiveModel.initial(year: date.year);

    final dayKey = HiveHelper.generateTransactionDayKey(date: date);
    final hiveModel = TransactionHiveModel.fromEntity(transaction);
    final monthIndex =
        transactionsYear.months.indexWhere((m) => m.month == month);

    MonthlyTransactionsHiveModel monthModel;

    if (monthIndex != -1) {
      monthModel = transactionsYear.months[monthIndex];
    } else {
      monthModel = MonthlyTransactionsHiveModel.initial(month: month);
      transactionsYear.months.add(monthModel);
    }

    final transactionsByDay = List<TransactionHiveModel>.from(
      monthModel.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(hiveModel);

    monthModel = monthModel.copyWith(
      transactions: {
        ...monthModel.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      transactionsYear.months[monthIndex] = monthModel;
    } else {
      final lastIndex = transactionsYear.months.length - 1;
      transactionsYear.months[lastIndex] = monthModel;
    }

    return transactionsYear;
  }

  static FinancialSummary updateGlobalSummary(
      {required Transaction transaction,
      FinancialSummaryHiveModel? financialSummaryModel}) {
    financialSummaryModel =
        financialSummaryModel ?? FinancialSummaryHiveModel.initial();

    final updatedGlobalSummary = FinancialCalculatorService.fromTransaction(
      transaction: transaction,
      balancesBySource: financialSummaryModel.balancesBySource,
    ).calculateUpdatedSummary(financialSummaryModel.toEntity());

    return updatedGlobalSummary;
  }
}
