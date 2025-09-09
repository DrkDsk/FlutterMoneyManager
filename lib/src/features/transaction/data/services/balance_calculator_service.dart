import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';

class BalanceCalculatorService {
  final bool isIncome;
  final String source;
  final int amount;
  final Map<String, int> balancesBySource;

  const BalanceCalculatorService(
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

  GlobalBalance calculateUpdatedBalance(GlobalBalance baseBalance) {
    final updatedSources = calculateUpdatedSources();

    final newIncome = baseBalance.income + (isIncome ? amount : 0);
    final newExpense = baseBalance.expense + (!isIncome ? amount : 0);
    final newTotal = baseBalance.total + (isIncome ? amount : -amount);

    final newAsset = updatedSources.entries
        .where((e) => kPositiveTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? 0 : e.value));

    final newDebt = updatedSources.entries
        .where((e) => kNegativeTransactionSources.contains(e.key))
        .fold<int>(0, (sum, e) => sum + (e.value < 0 ? -e.value : e.value));

    return baseBalance.copyWith(
      income: newIncome,
      expense: newExpense,
      total: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );
  }
}
