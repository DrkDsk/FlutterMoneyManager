import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'transaction_hive_model.g.dart';

@HiveType(typeId: 0)
class TransactionHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String type;

  @HiveField(2)
  final DateTime transactionDate;

  @HiveField(3)
  final int amount;

  @HiveField(4)
  final String categoryType;

  @HiveField(5)
  final String sourceType;

  TransactionHiveModel({
    required this.id,
    required this.type,
    required this.transactionDate,
    required this.amount,
    required this.categoryType,
    required this.sourceType,
  });

  TransactionHiveModel copyWith({
    String? id,
    String? type,
    DateTime? transactionDate,
    int? amount,
    String? categoryType,
    String? sourceType,
  }) {
    return TransactionHiveModel(
      id: id ?? this.id,
      type: type ?? this.type,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      categoryType: categoryType ?? this.categoryType,
      sourceType: sourceType ?? this.sourceType,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "type": type,
        "transactionDate": transactionDate.millisecondsSinceEpoch,
        "amount": amount,
        "categoryType": categoryType,
        "sourceType": sourceType
      };

  TransactionDto toDTO() {
    return TransactionDto(
        id: id,
        type: type == TransactionsConstants.kIncomeType
            ? TransactionTypEnum.income
            : TransactionTypEnum.expense,
        transactionDate: transactionDate,
        amount: amount,
        categoryType: categoryType,
        sourceType: sourceType);
  }

  factory TransactionHiveModel.fromMap(Map<String, dynamic> map) {
    final amountString = map['amount'].toString();
    final amount = int.tryParse(amountString) ?? 0;
    final dateString = map['transactionDate'].toString();
    final dateMilliseconds =
        int.tryParse(dateString) ?? DateTime.now().millisecondsSinceEpoch;

    final date = DateTime.fromMillisecondsSinceEpoch(dateMilliseconds);

    return TransactionHiveModel(
      id: map['id'].toString(),
      type: map['type'].toString(),
      transactionDate: date,
      amount: amount,
      categoryType: map['categoryType'].toString(),
      sourceType: map['sourceType'].toString(),
    );
  }

  factory TransactionHiveModel.fromDto(TransactionDto dto) {
    return TransactionHiveModel(
        id: dto.id ?? const Uuid().v4(),
        type: dto.type.name,
        transactionDate: dto.transactionDate,
        amount: dto.amount,
        categoryType: dto.categoryType ?? "",
        sourceType: dto.sourceType ?? "");
  }

  factory TransactionHiveModel.fromModel(TransactionModel model) {
    return TransactionHiveModel(
        id: model.id ?? const Uuid().v4(),
        type: model.type.name,
        transactionDate: model.transactionDate,
        amount: model.amount,
        categoryType: model.categoryType ?? "",
        sourceType: model.sourceType ?? "");
  }
}
