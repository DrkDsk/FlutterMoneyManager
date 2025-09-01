import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class ExpenseCategory extends TransactionCategory with EquatableMixin {
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

  @override
  List<Object?> get props => [name, icon];
}
