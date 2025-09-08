import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';

class AccountState with EquatableMixin {
  final List<AccountBalance> accountBalances;
  final GlobalBalance globalBalance;

  const AccountState(
      {this.accountBalances = const [], required this.globalBalance});

  @override
  List<Object> get props => [accountBalances, globalBalance];

  AccountState copyWith(
      {List<AccountBalance>? accountBalances, GlobalBalance? globalBalance}) {
    return AccountState(
        accountBalances: accountBalances ?? this.accountBalances,
        globalBalance: globalBalance ?? this.globalBalance);
  }

  factory AccountState.initial() {
    return const AccountState(
        globalBalance: GlobalBalance(
      income: 0,
      expense: 0,
      total: 0,
      asset: 0,
      balancesBySource: {},
    ));
  }
}
