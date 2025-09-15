import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';

class MonthlyTransactionsModel {
  final int month;

  final Map<String, List<TransactionModel>> transactions;

  const MonthlyTransactionsModel(
      {required this.month, required this.transactions});

  MonthlyTransactions toEntity() {
    return MonthlyTransactions(
      month: month,
      transactions: transactions.map(
        (key, list) => MapEntry(
          key,
          list.map((transaction) => transaction.toEntity()).toList(),
        ),
      ),
    );
  }

  factory MonthlyTransactionsModel.fromEntity(
    MonthlyTransactions entity,
  ) {
    return MonthlyTransactionsModel(
      month: entity.month,
      transactions: entity.transactions.map(
        (key, value) => MapEntry(
          key,
          value.map((t) => TransactionModel.fromEntity(t)).toList(),
        ),
      ),
    );
  }
}
