import 'package:flutter_money_manager/src/core/enums/expense_category_enum.dart';

class TransactionSource {
  final String name;
  final String icon;

  const TransactionSource({required this.icon, required this.name});

  ExpenseCategoryEnum getTExpenseCategoryype() {
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
}
