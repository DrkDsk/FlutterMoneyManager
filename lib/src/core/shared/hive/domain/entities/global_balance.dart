import 'package:equatable/equatable.dart';

class GlobalBalance with EquatableMixin {
  final int income;
  final int expense;
  final int total;
  final int asset;
  final Map<String, int> balancesBySource;

  const GlobalBalance(
      {required this.income,
      required this.expense,
      required this.asset,
      required this.total,
      required this.balancesBySource});

  @override
  List<Object?> get props => [income, expense, asset, total, balancesBySource];
}
