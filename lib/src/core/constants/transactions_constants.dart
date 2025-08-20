import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

const kDefaultAmountValue = "\$ 0";

const kDefaultTransactionsCategories = [
  Transactioncategory(
      name: "Car Loan", icon: "assets/icons/transactions/car_loan.png"),
  Transactioncategory(
      name: "Investments", icon: "assets/icons/transactions/investments.png"),
  Transactioncategory(name: "Bank", icon: "assets/icons/transactions/bank.png"),
  Transactioncategory(name: "Cash", icon: "assets/icons/transactions/cash.png"),
  Transactioncategory(
      name: "Credit Card", icon: "assets/icons/transactions/credit_card.png"),
  Transactioncategory(
      name: "Debit Card", icon: "assets/icons/transactions/debit_card.png"),
  Transactioncategory(
      name: "Electronic Money",
      icon: "assets/icons/transactions/electronic_money.png")
];
