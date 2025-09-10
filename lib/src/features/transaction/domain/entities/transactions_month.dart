import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class TransactionsMonth with EquatableMixin {
  final int month;

  final Map<String, List<Transaction>> transactions;

  const TransactionsMonth({required this.month, required this.transactions});

  TransactionsMonth copyWith({
    int? month,
    Map<String, List<Transaction>>? transactions,
  }) {
    return TransactionsMonth(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [month, transactions];
}
