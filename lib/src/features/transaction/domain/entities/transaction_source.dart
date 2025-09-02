import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';

class TransactionSource with EquatableMixin {
  final String name;
  final String icon;

  const TransactionSource({required this.name, required this.icon});

  factory TransactionSource.fromType(TransactionSourceEnum type) {
    switch (type) {
      case TransactionSourceEnum.carLoan:
        return const TransactionSource(
            name: "Car Loan",
            icon: "assets/icons/payment_sources/car_loan.png");
      case TransactionSourceEnum.investments:
        return const TransactionSource(
            name: "Investments",
            icon: "assets/icons/payment_sources/investments.png");
      case TransactionSourceEnum.bank:
        return const TransactionSource(
            name: "Bank", icon: "assets/icons/payment_sources/bank.png");
      case TransactionSourceEnum.cash:
        return const TransactionSource(
            name: "Cash", icon: "assets/icons/payment_sources/cash.png");
      case TransactionSourceEnum.creditCard:
        return const TransactionSource(
            name: "Credit Card",
            icon: "assets/icons/payment_sources/credit_card.png");
      case TransactionSourceEnum.debitCard:
        return const TransactionSource(
            name: "Debit Card",
            icon: "assets/icons/payment_sources/debit_card.png");
      case TransactionSourceEnum.electricMoney:
        return const TransactionSource(
            name: "Electronic Money",
            icon: "assets/icons/payment_sources/electronic_money.png");
    }
  }

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

  factory TransactionSource.fromString(String value) {
    switch (value.toLowerCase()) {
      case "carloan":
      case "car_loan":
        return const TransactionSource(
            name: "Car Loan",
            icon: "assets/icons/payment_sources/car_loan.png");
      case "investments":
        return const TransactionSource(
            name: "Investments",
            icon: "assets/icons/payment_sources/investments.png");
      case "bank":
        return const TransactionSource(
            name: "Bank", icon: "assets/icons/payment_sources/bank.png");
      case "cash":
        return const TransactionSource(
            name: "Cash", icon: "assets/icons/payment_sources/cash.png");
      case "creditcard":
      case "credit_card":
        return const TransactionSource(
            name: "Credit Card",
            icon: "assets/icons/payment_sources/credit_card.png");
      case "debitcard":
      case "debit_card":
        return const TransactionSource(
            name: "Debit Card",
            icon: "assets/icons/payment_sources/debit_card.png");
      case "electricmoney":
      case "electronicmoney":
      case "electronic_money":
        return const TransactionSource(
            name: "Electronic Money",
            icon: "assets/icons/payment_sources/electronic_money.png");
      default:
        throw ArgumentError("Unknown source string: $value");
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
