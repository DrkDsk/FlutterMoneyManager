import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';

sealed class TransactionsEvent {
  const TransactionsEvent();
}

class LoadTransactionsByMonth extends TransactionsEvent with EquatableMixin {
  final int? month;
  final int? year;

  const LoadTransactionsByMonth({this.month, this.year});

  @override
  List<Object?> get props => [month, year];
}

class UpdateMonth extends TransactionsEvent with EquatableMixin {
  final int monthIndex;

  const UpdateMonth({required this.monthIndex});

  @override
  List<Object?> get props => [monthIndex];
}

class UpdateBalance extends TransactionsEvent with EquatableMixin {
  final TransactionsSummary balance;

  const UpdateBalance({required this.balance});

  @override
  List<Object?> get props => [balance];
}
