import 'package:equatable/equatable.dart';

class TransactionSource with EquatableMixin {
  final String name;
  final String icon;

  const TransactionSource({required this.name, required this.icon});

  factory TransactionSource.fromString(String value) {
    switch (value.toLowerCase()) {
      case "car loan":
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
      case "credit card":
        return const TransactionSource(
            name: "Credit Card",
            icon: "assets/icons/payment_sources/credit_card.png");
      case "debit card":
        return const TransactionSource(
            name: "Debit Card",
            icon: "assets/icons/payment_sources/debit_card.png");
      case "electronic money":
        return const TransactionSource(
            name: "Electronic Money",
            icon: "assets/icons/payment_sources/electronic_money.png");
      default:
        return const TransactionSource(
            name: "Car Loan",
            icon: "assets/icons/payment_sources/car_loan.png");
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
