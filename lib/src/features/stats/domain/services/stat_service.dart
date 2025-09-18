import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

class StatService {
  List<ReportBreakdown> calculateBreakdown(
    List<TransactionModel> transactions,
    FinancialSummaryModel summary,
  ) {
    final Map<String, int> expensesBySource = {};
    final Map<String, int> incomesBySource = {};

    for (var tx in transactions) {
      final source = tx.categoryType ?? "Unknown";
      if (tx.type == TransactionTypEnum.expense) {
        expensesBySource[source] = (expensesBySource[source] ?? 0) + tx.amount;
      } else if (tx.type == TransactionTypEnum.income) {
        incomesBySource[source] = (incomesBySource[source] ?? 0) + tx.amount;
      }
    }

    final allSources = {
      ...expensesBySource.keys,
      ...incomesBySource.keys,
    };

    return allSources.map((source) {
      final expenseAmount = expensesBySource[source] ?? 0;
      final incomeAmount = incomesBySource[source] ?? 0;

      final percentOfExpenses =
          summary.expense > 0 ? (expenseAmount / summary.expense) * 100 : 0;

      final percentOfIncomes =
          summary.income > 0 ? (incomeAmount / summary.income) * 100 : 0;

      return ReportBreakdown(
        source: source,
        expenseAmount: expenseAmount,
        percentOfExpenses: percentOfExpenses.toDouble(),
        incomeAmount: incomeAmount,
        percentOfIncomes: percentOfIncomes.toDouble(),
      );
    }).toList();
  }
}
