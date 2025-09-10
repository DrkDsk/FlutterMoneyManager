import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class AccountBalance with EquatableMixin {
  final TransactionSource transactionSource;
  final int amount;

  const AccountBalance({required this.transactionSource, required this.amount});

  @override
  List<Object?> get props => [transactionSource, amount];
}
