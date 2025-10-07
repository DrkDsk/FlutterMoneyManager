class MonthlySummary {
  final int income;
  final int expense;
  final int total;

  const MonthlySummary(
      {required this.income, required this.expense, required this.total});

  MonthlySummary copyWith({
    int? income,
    int? expense,
    int? total,
  }) {
    return MonthlySummary(
      income: income ?? this.income,
      expense: expense ?? this.expense,
      total: total ?? this.total,
    );
  }

  factory MonthlySummary.initial() {
    return const MonthlySummary(income: 0, expense: 0, total: 0);
  }
}
