import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/expense_category_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class ExpenseCategory extends TransactionSource with EquatableMixin {
  const ExpenseCategory({
    required super.name,
    required super.icon,
  });

  ExpenseCategory copyWith({
    String? name,
    String? icon,
  }) {
    return ExpenseCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  factory ExpenseCategory.fromType(ExpenseCategoryEnum type) {
    switch (type) {
      case ExpenseCategoryEnum.food:
        return const ExpenseCategory(
            name: "Food", icon: "assets/icons/categories/food.png");
      case ExpenseCategoryEnum.tansportation:
        return const ExpenseCategory(
            name: "Transportation",
            icon: "assets/icons/categories/transportation.png");
      case ExpenseCategoryEnum.housing:
        return const ExpenseCategory(
            name: "Housing", icon: "assets/icons/categories/housing.png");
      case ExpenseCategoryEnum.utility:
        return const ExpenseCategory(
            name: "Utility", icon: "assets/icons/categories/utility.png");
      case ExpenseCategoryEnum.household:
        return const ExpenseCategory(
            name: "Household", icon: "assets/icons/categories/household.png");
      case ExpenseCategoryEnum.entertainment:
        return const ExpenseCategory(
            name: "Entertainment",
            icon: "assets/icons/categories/entertainment.png");
    }
  }

  ExpenseCategoryEnum getType() {
    switch (name) {
      case "Food":
        return ExpenseCategoryEnum.food;
      case "Transportation":
        return ExpenseCategoryEnum.tansportation;
      case "Housing":
        return ExpenseCategoryEnum.housing;
      case "utility":
        return ExpenseCategoryEnum.utility;
      case "Household":
        return ExpenseCategoryEnum.household;
      case "Entertainment":
        return ExpenseCategoryEnum.entertainment;
      default:
        return ExpenseCategoryEnum.food;
    }
  }

  @override
  List<Object?> get props => [name, icon];
}
