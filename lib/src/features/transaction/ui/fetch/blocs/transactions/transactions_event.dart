import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_balance.dart';

sealed class TransactionsEvent {
  const TransactionsEvent();
}

class LoadTransactionsByMonth extends TransactionsEvent with EquatableMixin {
  final int? monthIndex;

  const LoadTransactionsByMonth({this.monthIndex});

  @override
  List<Object?> get props => [monthIndex];
}

class UpdateMonth extends TransactionsEvent with EquatableMixin {
  final int monthIndex;

  const UpdateMonth({required this.monthIndex});

  @override
  List<Object?> get props => [monthIndex];
}

class UpdateBalance extends TransactionsEvent with EquatableMixin {
  final TransactionBalance balance;

  const UpdateBalance({required this.balance});

  @override
  List<Object?> get props => [balance];
}
