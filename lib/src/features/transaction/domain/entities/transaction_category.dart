import 'package:flutter_money_manager/src/core/enums/transaction_category_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/expense_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/income_category.dart';

class TransactionCategory {
  final String name;
  final String icon;

  const TransactionCategory({required this.icon, required this.name});

  TransactionCategoryEnum getCategoryType() {
    switch (name) {
      case "Food":
        return TransactionCategoryEnum.food;
      case "Transportation":
        return TransactionCategoryEnum.transportation;
      case "Housing":
        return TransactionCategoryEnum.housing;
      case "utility":
        return TransactionCategoryEnum.utility;
      case "Household":
        return TransactionCategoryEnum.household;
      case "Entertainment":
        return TransactionCategoryEnum.entertainment;
      case "Salary":
        return TransactionCategoryEnum.salary;
      case "Bonus":
        return TransactionCategoryEnum.bonus;
      case "Side Business":
        return TransactionCategoryEnum.sidebusiness;
      case "Investments":
        return TransactionCategoryEnum.investments;
      default:
        return TransactionCategoryEnum.food;
    }
  }

  factory TransactionCategory.fromType(TransactionCategoryEnum type) {
    switch (type) {
      case TransactionCategoryEnum.food:
        return const ExpenseCategory(
            name: "Food", icon: "assets/icons/categories/food.png");
      case TransactionCategoryEnum.transportation:
        return const ExpenseCategory(
            name: "Transportation",
            icon: "assets/icons/categories/transportation.png");
      case TransactionCategoryEnum.housing:
        return const ExpenseCategory(
            name: "Housing", icon: "assets/icons/categories/housing.png");
      case TransactionCategoryEnum.utility:
        return const ExpenseCategory(
            name: "Utility", icon: "assets/icons/categories/utility.png");
      case TransactionCategoryEnum.household:
        return const ExpenseCategory(
            name: "Household", icon: "assets/icons/categories/household.png");
      case TransactionCategoryEnum.entertainment:
        return const ExpenseCategory(
            name: "Entertainment",
            icon: "assets/icons/categories/entertainment.png");
      case TransactionCategoryEnum.salary:
        return const IncomeCategory(
            name: "Salary", icon: "assets/icons/categories/salary.png");
      case TransactionCategoryEnum.bonus:
        return const IncomeCategory(
            name: "Bonus", icon: "assets/icons/categories/bonus.png");
      case TransactionCategoryEnum.sidebusiness:
        return const IncomeCategory(
            icon: "assets/icons/categories/side_business.png",
            name: "Side Business");
      case TransactionCategoryEnum.investments:
        return const IncomeCategory(
            icon: "assets/icons/payment_sources/investments.png",
            name: "Investments");
    }
  }

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
        throw ArgumentError("Unknown category string: $value");
    }
  }
}
