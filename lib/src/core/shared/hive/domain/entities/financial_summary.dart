import 'package:equatable/equatable.dart';

class FinancialSummary with EquatableMixin {
  final int income;
  final int expense;
  final int netWorth;
  final int asset;
  final int debt;
  final Map<String, int> balancesBySource;

  const FinancialSummary(
      {required this.income,
      required this.expense,
      required this.asset,
      required this.netWorth,
      required this.debt,
      required this.balancesBySource});

  @override
  List<Object?> get props =>
      [income, expense, asset, netWorth, debt, balancesBySource];

  FinancialSummary copyWith({
    int? income,
    int? expense,
    int? netWorth,
    int? asset,
    int? debt,
    Map<String, int>? balancesBySource,
  }) {
    return FinancialSummary(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      netWorth: netWorth ?? this.netWorth,
      asset: asset ?? this.asset,
      debt: debt ?? this.debt,
      balancesBySource: balancesBySource ?? this.balancesBySource,
    );
  }

  factory FinancialSummary.initial() {
    return const FinancialSummary(
        income: 0,
        expense: 0,
        netWorth: 0,
        asset: 0,
        debt: 0,
        balancesBySource: {});
  }
}
