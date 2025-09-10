import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_month.dart';
import 'package:hive/hive.dart';

part 'transactions_month_hive_model.g.dart';

@HiveType(typeId: 5)
class TransactionsMonthHiveModel extends HiveObject {
  @HiveField(0)
  final int month;

  @HiveField(1)
  final Map<String, List<TransactionHiveModel>> transactions;

  TransactionsMonthHiveModel({required this.month, required this.transactions});

  TransactionsMonthHiveModel copyWith({
    int? month,
    Map<String, List<TransactionHiveModel>>? transactions,
  }) {
    return TransactionsMonthHiveModel(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  factory TransactionsMonthHiveModel.initial({required int month}) {
    return TransactionsMonthHiveModel(month: month, transactions: const {});
  }

  TransactionsMonth toEntity() {
    return TransactionsMonth(
      month: month,
      transactions: transactions.map(
        (key, list) => MapEntry(
          key,
          list.map((transaction) => transaction.toEntity()).toList(),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'transactions': transactions,
    };
  }
}
