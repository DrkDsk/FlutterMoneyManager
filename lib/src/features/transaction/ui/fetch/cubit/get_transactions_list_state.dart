import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

enum GetTransactionListStatus { initial, loading, error, success }

class GetTransactionListState with EquatableMixin {
  final List<TransactionsData> data;
  final GetTransactionListStatus status;
  final String? errorMessage;
  final String monthName;

  GetTransactionListState({
    this.data = const [],
    this.status = GetTransactionListStatus.initial,
    this.errorMessage,
    String? monthName,
  }) : monthName = monthName ?? DateTime.now().monthName;

  @override
  List<Object> get props => [data, status, monthName];

  GetTransactionListState copyWith(
      {List<TransactionsData>? data,
      GetTransactionListStatus? status,
      String? errorMessage,
      String? monthName}) {
    return GetTransactionListState(
        status: status ?? this.status,
        data: data ?? this.data,
        monthName: monthName ?? this.monthName,
        errorMessage: errorMessage ?? this.errorMessage);
  }
}
