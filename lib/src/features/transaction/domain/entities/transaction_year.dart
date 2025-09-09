import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_month.dart';

class TransactionYear with EquatableMixin {
  final int year;

  final List<TransactionsMonth> months;

  const TransactionYear({required this.year, required this.months});

  TransactionYear copyWith({
    int? year,
    List<TransactionsMonth>? months,
  }) {
    return TransactionYear(
      year: year ?? this.year,
      months: months ?? this.months,
    );
  }

  @override
  List<Object?> get props => [year, months];
}
