import 'package:equatable/equatable.dart';

class Transaction with EquatableMixin {
  final String? id;
  final String type;
  final DateTime transactionDate;
  final int amount;
  final String? categoryType;
  final String? sourceType;

  Transaction(
      {this.id,
      required this.type,
      DateTime? transactionDate,
      required this.amount,
      this.categoryType,
      this.sourceType})
      : transactionDate = transactionDate ?? DateTime.now();

  Transaction copyWith(
      {String? id,
      String? type,
      DateTime? transactionDate,
      int? amount,
      String? categoryType,
      String? sourceType}) {
    return Transaction(
        id: id ?? this.id,
        type: type ?? this.type,
        transactionDate: transactionDate ?? this.transactionDate,
        amount: amount ?? this.amount,
        categoryType: categoryType ?? this.categoryType,
        sourceType: sourceType ?? this.sourceType);
  }

  @override
  List<Object?> get props =>
      [id, type, transactionDate, amount, categoryType, sourceType];
}
