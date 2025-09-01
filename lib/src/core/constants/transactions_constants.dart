import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/income_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/expense_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_type.dart';

const kDefaultPaymentSources = [
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

const kDefaultExpenseCategories = [
  ExpenseCategory(name: "Food", icon: "assets/icons/categories/food.png"),
  ExpenseCategory(
      name: "Transportation",
      icon: "assets/icons/categories/transportation.png"),
  ExpenseCategory(name: "Housing", icon: "assets/icons/categories/housing.png"),
  ExpenseCategory(name: "Utility", icon: "assets/icons/categories/utility.png"),
  ExpenseCategory(
      name: "Household", icon: "assets/icons/categories/household.png"),
  ExpenseCategory(
      name: "Entertainment", icon: "assets/icons/categories/entertainment.png")
];

const kDefaultIncomeCategories = [
  IncomeCategory(name: "Salary", icon: "assets/icons/categories/salary.png"),
  IncomeCategory(name: "Bonus", icon: "assets/icons/categories/bonus.png"),
  IncomeCategory(
      name: "Side Business", icon: "assets/icons/categories/side_business.png"),
  IncomeCategory(
      name: "Investments",
      icon: "assets/icons/payment_sources/investments.png"),
];

const kDefaultTransactionTypes = [
  TransactionType(name: "Income", type: TransactionTypeEnum.income),
  TransactionType(name: "Expense", type: TransactionTypeEnum.expense)
];
