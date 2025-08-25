import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

class TransactionType with EquatableMixin {
  final String name;
  final TransactionTypeEnum type;

  const TransactionType({required this.name, required this.type});

  @override
  List<Object?> get props => [name, type];
}
