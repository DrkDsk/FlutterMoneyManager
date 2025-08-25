import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';

class Transaction {
  final String name;
  final TransactionType type;

  const Transaction({required this.name, required this.type});
}
