import 'package:hive/hive.dart';

part 'transaction_type_enum.g.dart';

@HiveType(typeId: 1)
enum TransactionTypeEnum {
  @HiveField(0)
  income,

  @HiveField(1)
  expense
}
