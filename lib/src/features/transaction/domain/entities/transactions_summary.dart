import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';

class TransactionsSummary with EquatableMixin {
  final List<TransactionsData> transactionsData;
  final MonthlySummary summary;

  const TransactionsSummary(
      {required this.transactionsData, required this.summary});

  @override
  List<Object?> get props => [transactionsData, summary];
}
