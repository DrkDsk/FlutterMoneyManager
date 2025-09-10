import 'package:flutter_money_manager/src/features/transaction/domain/entities/income_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/expense_category.dart';

final class TransactionsConstants {
  static const String kIncomeType = "income";
  static const String kExpenseType = "expense";

  static const kDefaultTransactionSources = [
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
        name: "Debit Card",
        icon: "assets/icons/payment_sources/debit_card.png"),
    TransactionSource(
        name: "Electronic Money",
        icon: "assets/icons/payment_sources/electronic_money.png")
  ];

  static const kDefaultExpenseCategories = [
    ExpenseCategory(name: "Food", icon: "assets/icons/categories/food.png"),
    ExpenseCategory(
        name: "Transportation",
        icon: "assets/icons/categories/transportation.png"),
    ExpenseCategory(
        name: "Housing", icon: "assets/icons/categories/housing.png"),
    ExpenseCategory(
        name: "Utility", icon: "assets/icons/categories/utility.png"),
    ExpenseCategory(
        name: "Household", icon: "assets/icons/categories/household.png"),
    ExpenseCategory(
        name: "Entertainment",
        icon: "assets/icons/categories/entertainment.png")
  ];

  static const kDefaultIncomeCategories = [
    IncomeCategory(name: "Salary", icon: "assets/icons/categories/salary.png"),
    IncomeCategory(name: "Bonus", icon: "assets/icons/categories/bonus.png"),
    IncomeCategory(
        name: "Side Business",
        icon: "assets/icons/categories/side_business.png"),
    IncomeCategory(
        name: "Investments",
        icon: "assets/icons/payment_sources/investments.png"),
  ];

  static const kPositiveTransactionSources = [
    "Cash",
    "Bank",
    "Investments",
    "Electronic Money",
    "Debit Card"
  ];

  static const kNegativeTransactionSources = [
    "Car Loan",
    "Credit Card",
  ];
}
