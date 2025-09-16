import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/DTO/financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/monthly_financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/monthly_transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_financial_summary_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_transactions_dto.dart';

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

  FinancialSummaryDto calculateUpdatedSummary(FinancialSummaryDto summaryDto) {
    final updatedSources = calculateUpdatedSources();

    final newIncome = summaryDto.income + (isIncome ? amount : 0);
    final newExpense = summaryDto.expense + (!isIncome ? amount : 0);
    final newTotal = summaryDto.netWorth + (isIncome ? amount : -amount);

    final newAsset = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kPositiveTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? 0 : e.value));

    final newDebt = updatedSources.entries
        .where((e) =>
            TransactionsConstants.kNegativeTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? -e.value : e.value));

    return summaryDto.copyWith(
      income: newIncome,
      expense: newExpense,
      netWorth: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );
  }

  static YearlyFinancialSummaryDto updateYearlyFinancialSummary(
      {required TransactionDto transactionDTO,
      required YearlyFinancialSummaryDto yearlyFinancialSummaryDto}) {
    final date = transactionDTO.transactionDate;
    final month = date.month;

    final yearModelAsMap = yearlyFinancialSummaryDto.toEntityMap();

    final monthIndexOfCurrentTransaction =
        yearlyFinancialSummaryDto.months.indexWhere((m) => m.month == month);

    final baseBalance = yearModelAsMap[month] ?? FinancialSummaryDto.initial();

    final calculator = FinancialCalculatorService.fromTransaction(
        transactionDto: transactionDTO,
        balancesBySource: baseBalance.balancesBySource);

    final updatedBalance = calculator.calculateUpdatedSummary(baseBalance);

    final monthBalance = MonthlyFinancialSummaryDto(
      month: month,
      summary: updatedBalance,
    );

    if (monthIndexOfCurrentTransaction != -1) {
      yearlyFinancialSummaryDto.months[monthIndexOfCurrentTransaction] =
          monthBalance;
    } else {
      yearlyFinancialSummaryDto.months.add(monthBalance);
    }

    return yearlyFinancialSummaryDto;
  }

  factory FinancialCalculatorService.fromTransaction(
      {required TransactionDto transactionDto,
      required Map<String, int> balancesBySource}) {
    final isIncome = transactionDto.type == TransactionTypEnum.income;
    final source = transactionDto.sourceType ?? "Unknown";
    final amount = transactionDto.amount;

    return FinancialCalculatorService(
        isIncome: isIncome,
        source: source,
        amount: amount,
        balancesBySource: balancesBySource);
  }

  static YearlyTransactionsDto updateYearlyTransactionHiveModel(
      {required YearlyTransactionsDto? yearlyTransactionsDto,
      required TransactionDto transactionDto}) {
    final date = transactionDto.transactionDate;
    final month = date.month;

    yearlyTransactionsDto =
        yearlyTransactionsDto ?? YearlyTransactionsDto.initial(year: date.year);

    final dayKey = HiveHelper.generateTransactionDayKey(date: date);
    final monthIndex =
        yearlyTransactionsDto.months.indexWhere((m) => m.month == month);

    MonthlyTransactionDto monthlyTransactionsDTO;

    if (monthIndex != -1) {
      monthlyTransactionsDTO = yearlyTransactionsDto.months[monthIndex];
    } else {
      monthlyTransactionsDTO = MonthlyTransactionDto.initial(month: month);
      yearlyTransactionsDto.months.add(monthlyTransactionsDTO);
    }

    final transactionsByDay = List<TransactionDto>.from(
      monthlyTransactionsDTO.transactions[dayKey] ?? [],
    );

    transactionsByDay.add(transactionDto);

    monthlyTransactionsDTO = monthlyTransactionsDTO.copyWith(
      transactions: {
        ...monthlyTransactionsDTO.transactions,
        dayKey: transactionsByDay,
      },
    );

    if (monthIndex != -1) {
      yearlyTransactionsDto.months[monthIndex] = monthlyTransactionsDTO;
    } else {
      final lastIndex = yearlyTransactionsDto.months.length - 1;
      yearlyTransactionsDto.months[lastIndex] = monthlyTransactionsDTO;
    }

    return yearlyTransactionsDto;
  }

  static FinancialSummaryDto updateGlobalSummary(
      {required TransactionDto transactionDto,
      FinancialSummaryDto? financialSummaryDto}) {
    financialSummaryDto = financialSummaryDto ?? FinancialSummaryDto.initial();

    final updatedGlobalSummary = FinancialCalculatorService.fromTransaction(
      transactionDto: transactionDto,
      balancesBySource: financialSummaryDto.balancesBySource,
    ).calculateUpdatedSummary(financialSummaryDto);

    return updatedGlobalSummary;
  }
}
