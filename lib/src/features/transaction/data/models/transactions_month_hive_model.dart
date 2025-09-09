import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_month.dart';
import 'package:hive/hive.dart';

part 'transactions_month_hive_model.g.dart';

@HiveType(typeId: 5)
class TransactionsMonthHiveModel extends HiveObject {
  @HiveField(0)
  final int month;

  @HiveField(1)
  final List<TransactionHiveModel> transactions;

  TransactionsMonthHiveModel({required this.month, required this.transactions});

  TransactionsMonthHiveModel copyWith({
    int? month,
    List<TransactionHiveModel>? transactions,
  }) {
    return TransactionsMonthHiveModel(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  TransactionsMonth toEntity() {
    return TransactionsMonth(
        month: month,
        transactions:
            transactions.map((transaction) => transaction.toEntity()).toList());
  }
}
