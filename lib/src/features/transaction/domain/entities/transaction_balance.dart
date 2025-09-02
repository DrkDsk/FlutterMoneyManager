import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

class TransactionBalance with EquatableMixin {
  final List<TransactionsData> transactionsData;
  final int income;
  final int expense;
  final int total;

  const TransactionBalance(
      {required this.transactionsData,
      required this.income,
      required this.total,
      required this.expense});

  @override
  List<Object?> get props => [transactionsData, income, expense, total];
}
