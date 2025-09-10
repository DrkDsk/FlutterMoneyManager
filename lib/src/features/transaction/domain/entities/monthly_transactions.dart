import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class MonthlyTransactions with EquatableMixin {
  final int month;

  final Map<String, List<Transaction>> transactions;

  const MonthlyTransactions({required this.month, required this.transactions});

  MonthlyTransactions copyWith({
    int? month,
    Map<String, List<Transaction>>? transactions,
  }) {
    return MonthlyTransactions(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  factory MonthlyTransactions.initial({required int month}) {
    return MonthlyTransactions(month: month, transactions: {});
  }

  @override
  List<Object?> get props => [month, transactions];
}
