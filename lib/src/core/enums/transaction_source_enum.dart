import 'package:hive/hive.dart';

part 'transaction_source_enum.g.dart';

@HiveType(typeId: 3)
enum TransactionSourceEnum {
  @HiveField(0)
  carLoan,

  @HiveField(1)
  investments,

  @HiveField(2)
  bank,

  @HiveField(3)
  cash,

  @HiveField(4)
  creditCard,

  @HiveField(5)
  debitCard,

  @HiveField(6)
  electricMoney
}
