import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class TransactionsData with EquatableMixin {
  final List<Transaction> transactions;
  final DateTime date;

  const TransactionsData({
    required this.transactions,
    required this.date,
  });

  @override
  List<Object?> get props => [transactions, date];
}
