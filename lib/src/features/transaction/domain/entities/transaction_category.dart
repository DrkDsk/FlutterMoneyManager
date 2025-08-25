import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_category_enum.dart';

class TransactionCategory with EquatableMixin {
  final String name;
  final String icon;

  const TransactionCategory({
    required this.name,
    required this.icon,
  });

  TransactionCategory copyWith({
    String? name,
    String? icon,
  }) {
    return TransactionCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
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
    }
  }

  TransactionCategoryEnum getType() {
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
      default:
        return TransactionCategoryEnum.food;
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
