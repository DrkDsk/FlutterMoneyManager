import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

final class FinancialCalculatorService {
  static FinancialSummary getFinancialSummary(
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
}
