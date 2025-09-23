import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

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
      id: entity.id,
      type: entity.type,
      transactionDate: entity.transactionDate,
      amount: entity.amount,
      categoryType: entity.categoryType!,
      sourceType: entity.sourceType!,
    );
  }

  factory TransactionModel.fromHive(TransactionHiveModel hive) {
    return TransactionModel(
        id: hive.id,
        type: hive.type == TransactionsConstants.kIncomeType
            ? TransactionTypEnum.income
            : TransactionTypEnum.expense,
        transactionDate: hive.transactionDate,
        amount: hive.amount,
        sourceType: hive.sourceType,
        categoryType: hive.categoryType);
  }

  TransactionModel copyWith({
    String? id,
    TransactionTypEnum? type,
    DateTime? transactionDate,
    int? amount,
    String? categoryType,
    String? sourceType,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      categoryType: categoryType ?? this.categoryType,
      sourceType: sourceType ?? this.sourceType,
    );
  }
}
