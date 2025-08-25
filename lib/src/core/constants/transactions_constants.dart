import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

const kDefaultAmountValue = "\$ 0";

const kDefaultTransactionSources = [
  TransactionSource(
      name: "Car Loan", icon: "assets/icons/payment_sources/car_loan.png"),
  TransactionSource(
      name: "Investments",
      icon: "assets/icons/payment_sources/investments.png"),
  TransactionSource(
      name: "Bank", icon: "assets/icons/payment_sources/bank.png"),
  TransactionSource(
      name: "Cash", icon: "assets/icons/payment_sources/cash.png"),
  TransactionSource(
      name: "Credit Card",
      icon: "assets/icons/payment_sources/credit_card.png"),
  TransactionSource(
      name: "Debit Card", icon: "assets/icons/payment_sources/debit_card.png"),
  TransactionSource(
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
