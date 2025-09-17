import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
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

  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'transactions': transactions,
    };
  }

  factory MonthlyTransactionsHiveModel.fromModel(
      MonthlyTransactionsModel model) {
    return MonthlyTransactionsHiveModel(
        month: model.month,
        transactions: model.transactions.map(
          (key, list) => MapEntry(
            key,
            list
                .map((transactionModel) =>
                    TransactionHiveModel.fromModel(transactionModel))
                .toList(),
          ),
        ));
  }
}
