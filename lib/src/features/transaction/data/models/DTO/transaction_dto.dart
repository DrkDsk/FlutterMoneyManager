import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';

class TransactionDto {
  final String? id;
  final TransactionTypEnum type;
  final DateTime transactionDate;
  final int amount;
  final String? categoryType;
  final String? sourceType;

  TransactionDto(
      {this.id,
      required this.type,
      required this.transactionDate,
      required this.amount,
      this.categoryType,
      this.sourceType});

  factory TransactionDto.fromModel(TransactionModel model) {
    return TransactionDto(
      id: model.id,
      type: model.type,
      transactionDate: model.transactionDate,
      amount: model.amount,
      categoryType: model.categoryType,
      sourceType: model.sourceType,
    );
  }

  TransactionModel toModel() {
    return TransactionModel(
        id: id,
        type: type,
        transactionDate: transactionDate,
        amount: amount,
        categoryType: categoryType,
        sourceType: sourceType);
  }
}
