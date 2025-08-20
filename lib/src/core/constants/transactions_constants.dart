import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';

const kDefaultAmountValue = "\$ 0";

const kDefaultPaymentResources = [
  PaymentSource(
      name: "Car Loan", icon: "assets/icons/transactions/car_loan.png"),
  PaymentSource(
      name: "Investments", icon: "assets/icons/transactions/investments.png"),
  PaymentSource(name: "Bank", icon: "assets/icons/transactions/bank.png"),
  PaymentSource(name: "Cash", icon: "assets/icons/transactions/cash.png"),
  PaymentSource(
      name: "Credit Card", icon: "assets/icons/transactions/credit_card.png"),
  PaymentSource(
      name: "Debit Card", icon: "assets/icons/transactions/debit_card.png"),
  PaymentSource(
      name: "Electronic Money",
      icon: "assets/icons/transactions/electronic_money.png")
];
