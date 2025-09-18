import 'package:equatable/equatable.dart';

class ReportBreakdown with EquatableMixin {
  final String source;

  final int expenseAmount;
  final double percentOfExpenses;
  final double percentOfIncomes;
  final int incomeAmount;

  const ReportBreakdown({
    required this.source,
    required this.expenseAmount,
    required this.percentOfExpenses,
    required this.percentOfIncomes,
    required this.incomeAmount,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        source,
        expenseAmount,
        percentOfExpenses,
        percentOfIncomes,
        incomeAmount,
      ];
}
