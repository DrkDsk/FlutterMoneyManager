import 'package:collection/collection.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/top_five_summary.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/services/financial_summary_service.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';

class FinancialSummaryRepositoryImpl implements FinancialSummaryRepository {
  final FinancialSummaryService _financialSummaryService;
  final TransactionService _transactionService;

  const FinancialSummaryRepositoryImpl(
      {required FinancialSummaryService financialSummaryService,
      required TransactionService transactionService})
      : _financialSummaryService = financialSummaryService,
        _transactionService = transactionService;

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final updatedSummary =
        await _financialSummaryService.getGlobalFinancialSummary();

    return updatedSummary;
  }

  @override
  Future<TopFiveSummary> getTopFiveSummary(
      {required int month,
      required int year,
      required TransactionTypEnum type}) async {
    final allTransactions = await _transactionService.getTransactionsMonth(
        year: year, month: month);

    final transactions = allTransactions
        .where((transaction) => transaction.type == type)
        .toList();

    final top5Entries = transactions
        .groupListsBy((tx) => tx.categoryType ?? 'Unknown')
        .map((category, txList) => MapEntry(
              category,
              txList.fold<int>(0, (sum, tx) => sum + tx.amount),
            ))
        .entries
        .sorted((a, b) => b.value.compareTo(a.value))
        .take(5)
        .toList();

    final totalTop5 =
        top5Entries.fold<int>(0, (sum, entry) => sum + entry.value);

    final top5Breakdown = top5Entries.map((entry) {
      final percent = totalTop5 == 0 ? 0 : (entry.value / totalTop5) * 100;
      return StatBreakdown(
        source: entry.key,
        amount: entry.value,
        percent: double.parse(percent.toStringAsFixed(3)),
      );
    }).toList();

    return TopFiveSummary(expenseStats: top5Breakdown);
  }
}
