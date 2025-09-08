import 'package:equatable/equatable.dart';

class GlobalBalance with EquatableMixin {
  final int income;
  final int expense;
  final int total;
  final int asset;

  const GlobalBalance(
      {required this.income,
      required this.expense,
      required this.asset,
      required this.total});

  @override
  List<Object?> get props => [income, expense, asset, total];
}
