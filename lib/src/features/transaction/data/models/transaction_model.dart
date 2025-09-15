import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:uuid/uuid.dart';

class TransactionModel {
  final String? id;
  final TransactionTypEnum type;
  final DateTime transactionDate;
  final int amount;
  final String? categoryType;
  final String? sourceType;

  TransactionModel(
      {this.id,
      required this.type,
      required this.transactionDate,
      required this.amount,
      this.categoryType,
      this.sourceType});

  Transaction toEntity() {
    return Transaction(
        id: id,
        type: type,
        transactionDate: transactionDate,
        amount: amount,
        categoryType: categoryType,
        sourceType: sourceType);
  }

  factory TransactionModel.fromEntity(Transaction entity) {
    return TransactionModel(
      id: entity.id ?? const Uuid().v4(),
      type: entity.type,
      transactionDate: entity.transactionDate,
      amount: entity.amount,
      categoryType: entity.categoryType!,
      sourceType: entity.sourceType!,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type.name,
      'transactionDate': transactionDate.toIso8601String(),
      'amount': amount,
      'categoryType': categoryType,
      'sourceType': sourceType,
    };
  }
}
