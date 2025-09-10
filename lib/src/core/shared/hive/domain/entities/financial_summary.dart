import 'package:equatable/equatable.dart';

class FinancialSummary with EquatableMixin {
  final int income;
  final int expense;
  final int total;
  final int asset;
  final int debt;
  final Map<String, int> balancesBySource;

  const FinancialSummary(
      {required this.income,
      required this.expense,
      required this.asset,
      required this.total,
      required this.debt,
      required this.balancesBySource});

  @override
  List<Object?> get props =>
      [income, expense, asset, total, debt, balancesBySource];

  FinancialSummary copyWith({
    int? income,
    int? expense,
    int? total,
    int? asset,
    int? debt,
    Map<String, int>? balancesBySource,
  }) {
    return FinancialSummary(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      total: total ?? this.total,
      asset: asset ?? this.asset,
      debt: debt ?? this.debt,
      balancesBySource: balancesBySource ?? this.balancesBySource,
    );
  }
}
