import 'package:equatable/equatable.dart';

import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

enum GetTransactionListStatus { initial, loading, error, success }

class GetTransactionListState with EquatableMixin {
  final List<Transaction> transactions;
  final GetTransactionListStatus status;
  final String? errorMessage;

  const GetTransactionListState(
      {this.transactions = const [],
      this.errorMessage,
      this.status = GetTransactionListStatus.initial});

  @override
  List<Object> get props => [transactions, status];

  GetTransactionListState copyWith({
    List<Transaction>? transactions,
    GetTransactionListStatus? status,
    String? errorMessage,
  }) {
    return GetTransactionListState(
        status: status ?? this.status,
        transactions: transactions ?? this.transactions,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
