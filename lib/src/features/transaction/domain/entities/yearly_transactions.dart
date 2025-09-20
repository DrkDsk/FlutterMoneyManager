import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';

class YearlyTransactions {
  final int year;

  final List<MonthlyTransactions> months;

  const YearlyTransactions({required this.year, required this.months});

  factory YearlyTransactions.initial({required int year}) {
    return YearlyTransactions(year: year, months: []);
  }

  YearlyTransactions copyWith({
    int? year,
    List<MonthlyTransactions>? months,
  }) {
    return YearlyTransactions(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }
}
