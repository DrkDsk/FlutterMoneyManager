import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

enum GetTransactionListStatus { initial, loading, error, success }

class GetTransactionListState with EquatableMixin {
  final List<TransactionsData> transactions;
  final GetTransactionListStatus status;
  final String? errorMessage;
  final String monthName;
  final int income;
  final int expense;
  final int total;

  GetTransactionListState({
    this.transactions = const [],
    this.status = GetTransactionListStatus.initial,
    this.errorMessage,
    this.income = 0,
    this.expense = 0,
    this.total = 0,
    String? monthName,
  }) : monthName = monthName ?? DateTime.now().monthName;

  @override
  List<Object> get props =>
      [transactions, status, monthName, income, expense, total];

  GetTransactionListState copyWith(
      {List<TransactionsData>? transactions,
      GetTransactionListStatus? status,
      int? income,
      int? expense,
      int? total,
      String? errorMessage,
      String? monthName}) {
    return GetTransactionListState(
        status: status ?? this.status,
        transactions: transactions ?? this.transactions,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        total: total ?? this.total,
        monthName: monthName ?? this.monthName,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
