import 'package:flutter_money_manager/src/core/enums/transaction_category_enum.dart';

class TransactionCategory {
  final String name;
  final String icon;

  const TransactionCategory({required this.icon, required this.name});

  TransactionCategoryEnum getCategoryType() {
    switch (name) {
      case "Food":
        return TransactionCategoryEnum.food;
      case "Transportation":
        return TransactionCategoryEnum.tansportation;
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
        return const TransactionCategory(
            name: "Food", icon: "assets/icons/categories/food.png");
      case TransactionCategoryEnum.tansportation:
        return const TransactionCategory(
            name: "Transportation",
            icon: "assets/icons/categories/transportation.png");
      case TransactionCategoryEnum.housing:
        return const TransactionCategory(
            name: "Housing", icon: "assets/icons/categories/housing.png");
      case TransactionCategoryEnum.utility:
        return const TransactionCategory(
            name: "Utility", icon: "assets/icons/categories/utility.png");
      case TransactionCategoryEnum.household:
        return const TransactionCategory(
            name: "Household", icon: "assets/icons/categories/household.png");
      case TransactionCategoryEnum.entertainment:
        return const TransactionCategory(
            name: "Entertainment",
            icon: "assets/icons/categories/entertainment.png");
      case TransactionCategoryEnum.salary:
        return const TransactionCategory(
            name: "Salary", icon: "assets/icons/categories/salary.png");
      case TransactionCategoryEnum.bonus:
        return const TransactionCategory(
            name: "Bonus", icon: "assets/icons/categories/bonus.png");
      case TransactionCategoryEnum.sidebusiness:
        return const TransactionCategory(
            icon: "assets/icons/categories/side_business.png",
            name: "Side Business");
      case TransactionCategoryEnum.investments:
        return const TransactionCategory(
            icon: "assets/icons/payment_sources/investments.png",
            name: "Investments");
    }
  }
}
