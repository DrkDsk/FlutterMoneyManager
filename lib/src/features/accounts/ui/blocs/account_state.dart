import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';

class AccountState with EquatableMixin {
  final List<AccountBalance> accountBalances;

  const AccountState({
    this.accountBalances = const [],
  });

  @override
  List<Object> get props => [accountBalances];

  AccountState copyWith({
    List<AccountBalance>? accountBalances,
  }) {
    return AccountState(
      accountBalances: accountBalances ?? this.accountBalances,
    );
  }
}
