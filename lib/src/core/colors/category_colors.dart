import 'package:flutter/material.dart';

class CategoryColors {
  static Color food = const Color.fromARGB(255, 255, 94, 1);
  static Color transportation = Colors.grey.shade600;
  static Color housing = const Color.fromARGB(236, 192, 248, 108);
  static Color utility = const Color.fromARGB(236, 78, 193, 255);
  static Color household = const Color.fromARGB(205, 243, 185, 91);
  static Color entertainment = const Color.fromARGB(205, 72, 107, 250);
  static Color salary = const Color.fromARGB(160, 148, 238, 133);
  static Color bonus = const Color.fromARGB(205, 124, 232, 248);
  static Color sideBusiness = const Color.fromARGB(202, 253, 38, 0);
  static Color investments = const Color.fromARGB(205, 243, 98, 138);

  static Color getCategoryColor(String category) {
    switch (category) {
      case ("food"):
        return CategoryColors.food;
      case ("transportation"):
        return CategoryColors.transportation;
      case ("housing"):
        return CategoryColors.housing;
      case ("utility"):
        return CategoryColors.utility;
      case ("household"):
        return CategoryColors.household;
      case ("entertainment"):
        return CategoryColors.entertainment;
      case ("salary"):
        return CategoryColors.salary;
      case ("bonus"):
        return CategoryColors.bonus;
      case ("side business"):
        return CategoryColors.sideBusiness;
      case ("investments"):
        return CategoryColors.investments;
      default:
        return CategoryColors.transportation;
    }
  }
}
