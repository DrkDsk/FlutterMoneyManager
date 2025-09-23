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

  @override
  List<Object?> get props => [transactionsData, income, expense, total];
}
