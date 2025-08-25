import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type.dart';

class Transaction with EquatableMixin {
  final String name;
  final TransactionType type;

  const Transaction({required this.name, required this.type});

  @override
  List<Object?> get props => [name, type];
}
