import 'package:equatable/equatable.dart';

import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

enum TransactionTypeStatus { initial, loading, error, success }

sealed class SideEffect {
  const SideEffect();
}

class TransactionBlockedLoadingEffect extends SideEffect {
  const TransactionBlockedLoadingEffect();
}

class TransactionNavigationSideEffect extends SideEffect {
  const TransactionNavigationSideEffect();
}

class TransactionShowErrorSideEffect extends SideEffect {
  const TransactionShowErrorSideEffect();
}

class TransactionsState with EquatableMixin {
  final List<TransactionsData> transactions;
  final int income;
  final int expense;
  final int total;
  final String monthName;
  final int monthIndex;
  final String message;
  final TransactionTypeStatus status;

  const TransactionsState(
      {this.transactions = const [],
      this.income = 0,
      this.expense = 0,
      required this.monthName,
      required this.monthIndex,
      this.message = "",
      this.status = TransactionTypeStatus.initial,
      this.total = 0});

  factory TransactionsState.initial() {
    final now = DateTime.now();
    return TransactionsState(
      monthName: now.monthName,
      monthIndex: now.month,
    );
  }

  @override
  List<Object> get props =>
      [transactions, income, expense, total, monthName, message, status];

  TransactionsState copyWith(
      {List<TransactionsData>? transactions,
      int? income,
      int? expense,
      int? total,
      String? monthName,
      int? monthIndex,
      TransactionTypeStatus? status,
      String? message}) {
    return TransactionsState(
        transactions: transactions ?? this.transactions,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        total: total ?? this.total,
        monthName: monthName ?? this.monthName,
        monthIndex: monthIndex ?? this.monthIndex,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
