import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';

class AccountState with EquatableMixin {
  final List<AccountSummaryItem> accountSummaries;
  final FinancialSummary financialSummary;

  const AccountState(
      {this.accountSummaries = const [], required this.financialSummary});

  @override
  List<Object> get props => [accountSummaries, financialSummary];

  AccountState copyWith(
      {List<AccountSummaryItem>? accountSummaries,
      FinancialSummary? financialSummary}) {
    return AccountState(
        accountSummaries: accountSummaries ?? this.accountSummaries,
        financialSummary: financialSummary ?? this.financialSummary);
  }

  factory AccountState.initial() {
    return const AccountState(
        financialSummary: FinancialSummary(
      income: 0,
      expense: 0,
      netWorth: 0,
      asset: 0,
      debt: 0,
      balancesBySource: {},
    ));
  }
}
