import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class IncomeCategory extends TransactionCategory {
  const IncomeCategory({
    required super.name,
    required super.icon,
  });

  IncomeCategory copyWith({
    String? name,
    String? icon,
  }) {
    return IncomeCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }
}
