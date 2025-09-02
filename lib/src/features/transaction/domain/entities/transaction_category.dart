import 'package:flutter_money_manager/src/features/transaction/domain/entities/expense_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/income_category.dart';

class TransactionCategory {
  final String name;
  final String icon;

  const TransactionCategory({required this.icon, required this.name});

  factory TransactionCategory.fromString(String value) {
    switch (value.toLowerCase()) {
      case "food":
        return const ExpenseCategory(
            name: "Food", icon: "assets/icons/categories/food.png");
      case "transportation":
        return const ExpenseCategory(
            name: "Transportation",
            icon: "assets/icons/categories/transportation.png");
      case "housing":
        return const ExpenseCategory(
            name: "Housing", icon: "assets/icons/categories/housing.png");
      case "utility":
        return const ExpenseCategory(
            name: "Utility", icon: "assets/icons/categories/utility.png");
      case "household":
        return const ExpenseCategory(
            name: "Household", icon: "assets/icons/categories/household.png");
      case "entertainment":
        return const ExpenseCategory(
            name: "Entertainment",
            icon: "assets/icons/categories/entertainment.png");
      case "salary":
        return const IncomeCategory(
            name: "Salary", icon: "assets/icons/categories/salary.png");
      case "bonus":
        return const IncomeCategory(
            name: "Bonus", icon: "assets/icons/categories/bonus.png");
      case "sidebusiness":
      case "side_business":
        return const IncomeCategory(
            icon: "assets/icons/categories/side_business.png",
            name: "Side Business");
      case "investments":
        return const IncomeCategory(
            icon: "assets/icons/payment_sources/investments.png",
            name: "Investments");
      default:
        return const ExpenseCategory(
            name: "Food", icon: "assets/icons/categories/food.png");
    }
  }
}
