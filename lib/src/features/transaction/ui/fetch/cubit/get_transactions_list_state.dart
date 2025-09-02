import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

enum GetTransactionListStatus { initial, loading, error, success }

class GetTransactionListState with EquatableMixin {
  final List<TransactionsData> data;
  final GetTransactionListStatus status;
  final String? errorMessage;
  final String monthName;

  const GetTransactionListState(
      {this.data = const [],
      this.errorMessage,
      this.monthName = "",
      this.status = GetTransactionListStatus.initial});

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
