import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

const kDefaultAmountValue = "\$ 0";

const kDefaultPaymentResources = [
  PaymentSource(
      name: "Car Loan", icon: "assets/icons/payment_sources/car_loan.png"),
  PaymentSource(
      name: "Investments",
      icon: "assets/icons/payment_sources/investments.png"),
  PaymentSource(name: "Bank", icon: "assets/icons/payment_sources/bank.png"),
  PaymentSource(name: "Cash", icon: "assets/icons/payment_sources/cash.png"),
  PaymentSource(
      name: "Credit Card",
      icon: "assets/icons/payment_sources/credit_card.png"),
  PaymentSource(
      name: "Debit Card", icon: "assets/icons/payment_sources/debit_card.png"),
  PaymentSource(
      name: "Electronic Money",
      icon: "assets/icons/payment_sources/electronic_money.png")
];

const kDefaultTransactionsCategory = [
  TransactionCategory(name: "Food", icon: "assets/icons/categories/food.png"),
  TransactionCategory(
      name: "Transportation",
      icon: "assets/icons/categories/transportation.png"),
  TransactionCategory(
      name: "Housing", icon: "assets/icons/categories/housing.png"),
  TransactionCategory(
      name: "Utility", icon: "assets/icons/categories/utility.png"),
  TransactionCategory(
      name: "Household", icon: "assets/icons/categories/household.png"),
  TransactionCategory(
      name: "Entertainment", icon: "assets/icons/categories/entertainment.png")
];
