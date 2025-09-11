import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

class TransactionsSummary with EquatableMixin {
  final List<TransactionsData> transactionsData;
  final int income;
  final int expense;
  final int total;

  const TransactionsSummary(
      {required this.transactionsData,
      required this.income,
      required this.total,
      required this.expense});

  factory TransactionsSummary.initial() {
    return const TransactionsSummary(
        transactionsData: [], income: 0, total: 0, expense: 0);
  }

  TransactionsSummary copyWith({
    List<TransactionsData>? transactionsData,
    int? income,
    int? expense,
    int? total,
  }) {
    return TransactionsSummary(
      transactionsData: transactionsData ?? this.transactionsData,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      total: total ?? this.total,
    );
  }

  @override
  List<Object?> get props => [transactionsData, income, expense, total];
}
