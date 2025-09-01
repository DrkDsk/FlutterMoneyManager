import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_source_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class PaymentSource extends TransactionSource with EquatableMixin {
  const PaymentSource({required super.name, required super.icon});

  factory PaymentSource.fromType(PaymentSourceEnum type) {
    switch (type) {
      case PaymentSourceEnum.carLoan:
        return const PaymentSource(
            name: "Car Loan",
            icon: "assets/icons/payment_sources/car_loan.png");
      case PaymentSourceEnum.investments:
        return const PaymentSource(
            name: "Investments",
            icon: "assets/icons/payment_sources/investments.png");
      case PaymentSourceEnum.bank:
        return const PaymentSource(
            name: "Bank", icon: "assets/icons/payment_sources/bank.png");
      case PaymentSourceEnum.cash:
        return const PaymentSource(
            name: "Cash", icon: "assets/icons/payment_sources/cash.png");
      case PaymentSourceEnum.creditCard:
        return const PaymentSource(
            name: "Credit Card",
            icon: "assets/icons/payment_sources/credit_card.png");
      case PaymentSourceEnum.debitCard:
        return const PaymentSource(
            name: "Debit Card",
            icon: "assets/icons/payment_sources/debit_card.png");
      case PaymentSourceEnum.electricMoney:
        return const PaymentSource(
            name: "Electronic Money",
            icon: "assets/icons/payment_sources/electronic_money.png");
    }
  }

  PaymentSourceEnum getType() {
    switch (name) {
      case "Car Loan":
        return PaymentSourceEnum.carLoan;
      case "Investments":
        return PaymentSourceEnum.investments;
      case "Bank":
        return PaymentSourceEnum.bank;
      case "Cash":
        return PaymentSourceEnum.cash;
      case "Credit Card":
        return PaymentSourceEnum.creditCard;
      case "Debit Card":
        return PaymentSourceEnum.debitCard;
      case "Electronic Money":
        return PaymentSourceEnum.electricMoney;
      default:
        return PaymentSourceEnum.carLoan;
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
