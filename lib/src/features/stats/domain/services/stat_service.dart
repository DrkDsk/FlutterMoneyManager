import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

class StatService {
  List<StatBreakdown> calculateBreakdown(List<TransactionModel> transactions,
      FinancialSummaryModel summary, TransactionTypEnum selectedType) {
    final Map<String, int> sources = {};

    for (var tx in transactions) {
      final source = tx.categoryType ?? "Unknown";
      if (tx.type == selectedType) {
        sources[source] = (sources[source] ?? 0) + tx.amount;
      }
    }

    final allSources = {
      ...sources.keys,
    };

    return allSources.map((source) {
      final amount = sources[source] ?? 0;

      double percent = 0;

      if (selectedType == TransactionTypEnum.income) {
        percent = summary.income > 0 ? (amount / summary.income) * 100 : 0;
      } else {
        percent = summary.expense > 0 ? (amount / summary.expense) * 100 : 0;
      }

      return StatBreakdown(
        source: source,
        amount: amount,
        percent: percent.toDouble(),
      );
    }).toList();
  }
}
