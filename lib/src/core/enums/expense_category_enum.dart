import 'package:hive_flutter/hive_flutter.dart';

part 'expense_category_enum.g.dart';

@HiveType(typeId: 2)
enum ExpenseCategoryEnum {
  @HiveField(0)
  food,

  @HiveField(1)
  tansportation,

  @HiveField(2)
  housing,

  @HiveField(3)
  utility,

  @HiveField(4)
  household,

  @HiveField(5)
  entertainment
}
