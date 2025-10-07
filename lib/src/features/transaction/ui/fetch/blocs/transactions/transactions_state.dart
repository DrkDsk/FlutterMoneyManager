import 'package:equatable/equatable.dart';

import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';
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
  final MonthlySummary summary;
  final String monthName;
  final int monthIndex;
  final String message;
  final TransactionTypeStatus status;

  const TransactionsState(
      {this.transactions = const [],
      required this.summary,
      required this.monthName,
      required this.monthIndex,
      this.message = "",
      this.status = TransactionTypeStatus.initial});

  factory TransactionsState.initial() {
    final now = DateTime.now();
    return TransactionsState(
        monthName: now.monthName,
        monthIndex: now.month,
        summary: MonthlySummary.initial());
  }

  @override
  List<Object> get props => [transactions, monthName, message, status];

  TransactionsState copyWith(
      {List<TransactionsData>? transactions,
      String? monthName,
      int? monthIndex,
      TransactionTypeStatus? status,
      MonthlySummary? summary,
      String? message}) {
    return TransactionsState(
        transactions: transactions ?? this.transactions,
        summary: summary ?? this.summary,
        monthName: monthName ?? this.monthName,
        monthIndex: monthIndex ?? this.monthIndex,
        status: status ?? this.status,
        message: message ?? this.message);
  }
}
