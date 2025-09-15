import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_transactions.dart';
import 'package:hive/hive.dart';

part 'monthly_transactions_hive_model.g.dart';

@HiveType(typeId: 5)
class MonthlyTransactionsHiveModel extends HiveObject {
  @HiveField(0)
  final int month;

  @HiveField(1)
  final Map<String, List<TransactionHiveModel>> transactions;

  MonthlyTransactionsHiveModel(
      {required this.month, required this.transactions});

  MonthlyTransactionsHiveModel copyWith({
    int? month,
    Map<String, List<TransactionHiveModel>>? transactions,
  }) {
    return MonthlyTransactionsHiveModel(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }

  factory MonthlyTransactionsHiveModel.initial({required int month}) {
    return MonthlyTransactionsHiveModel(month: month, transactions: {});
  }

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

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'transactions': transactions,
    };
  }

  factory MonthlyTransactionsHiveModel.fromEntity(
    MonthlyTransactions entity,
  ) {
    return MonthlyTransactionsHiveModel(
      month: entity.month,
      transactions: entity.transactions.map(
        (key, value) => MapEntry(
          key,
          value.map((t) => TransactionHiveModel.fromEntity(t)).toList(),
        ),
      ),
    );
  }
}
