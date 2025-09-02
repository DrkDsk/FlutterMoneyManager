import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

class TransactionsData with EquatableMixin {
  final List<Transaction> transactions;
  final DateTime date;
  final int incomeBalance;
  final int expenseBalance;

  const TransactionsData(
      {required this.transactions,
      required this.date,
      required this.incomeBalance,
      required this.expenseBalance});

  @override
  List<Object?> get props =>
      [transactions, date, incomeBalance, expenseBalance];
}
