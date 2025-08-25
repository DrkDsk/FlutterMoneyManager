import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';

class TransactionSource with EquatableMixin {
  final String name;
  final String icon;

  const TransactionSource({required this.name, required this.icon});

  TransactionSourceEnum getType() {
    switch (name) {
      case "Car Loan":
        return TransactionSourceEnum.carLoan;
      case "Investments":
        return TransactionSourceEnum.investments;
      case "Bank":
        return TransactionSourceEnum.bank;
      case "Cash":
        return TransactionSourceEnum.cash;
      case "Credit Card":
        return TransactionSourceEnum.creditCard;
      case "Debit Card":
        return TransactionSourceEnum.debitCard;
      case "Electronic Money":
        return TransactionSourceEnum.electricMoney;
      default:
        return TransactionSourceEnum.carLoan;
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
