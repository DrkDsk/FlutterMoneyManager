import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';

class MonthlyTransactionDto {
  final int month;

  final Map<String, List<TransactionDto>> transactions;

  const MonthlyTransactionDto(
      {required this.month, required this.transactions});

  factory MonthlyTransactionDto.initial({required int month}) {
    return MonthlyTransactionDto(month: month, transactions: {});
  }

  MonthlyTransactionsModel toModel() {
    return MonthlyTransactionsModel(
        month: month,
        transactions: transactions.map(
          (key, list) => MapEntry(
            key,
            list.map((transaction) => transaction.toModel()).toList(),
          ),
        ));
  }

  factory MonthlyTransactionDto.fromModel(MonthlyTransactionsModel model) {
    return MonthlyTransactionDto(
        month: model.month,
        transactions: model.transactions.map(
          (key, list) => MapEntry(
            key,
            list
                .map((transactionModel) =>
                    TransactionDto.fromModel(transactionModel))
                .toList(),
          ),
        ));
  }

  MonthlyTransactionDto copyWith({
    int? month,
    Map<String, List<TransactionDto>>? transactions,
  }) {
    return MonthlyTransactionDto(
      month: month ?? this.month,
      transactions: transactions ?? this.transactions,
    );
  }
}
