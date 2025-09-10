import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';

class AccountState with EquatableMixin {
  final List<AccountBalance> accountBalances;
  final FinancialSummary globalBalance;

  const AccountState(
      {this.accountBalances = const [], required this.globalBalance});

  @override
  List<Object> get props => [accountBalances, globalBalance];

  AccountState copyWith(
      {List<AccountBalance>? accountBalances,
      FinancialSummary? globalBalance}) {
    return AccountState(
        accountBalances: accountBalances ?? this.accountBalances,
        globalBalance: globalBalance ?? this.globalBalance);
  }

  factory AccountState.initial() {
    return const AccountState(
        globalBalance: FinancialSummary(
      income: 0,
      expense: 0,
      total: 0,
      asset: 0,
      debt: 0,
      balancesBySource: {},
    ));
  }
}
