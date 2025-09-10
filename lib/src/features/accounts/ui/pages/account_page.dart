import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_divider.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_bloc.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_event.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_state.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/widgets/account_transaction_row.dart';
import 'package:flutter_money_manager/src/features/accounts/ui/widgets/info_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late AccountBloc _accountBloc;

  @override
  void initState() {
    super.initState();
    _accountBloc = context.read<AccountBloc>();
    _accountBloc.add(LoadTransactionsSource());
    _accountBloc.add(const GetGlobalBalance());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      scrollDirection: Axis.vertical,
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.cyan.shade800.customOpacity(0.70)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InfoBloc(
                          title: "Net Worth",
                          value: "\$ ${state.financialSummary.total}",
                          titleStyle: theme.textTheme.titleLarge?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InfoBloc(
                          title: "Total Assets",
                          value: "\$ ${state.financialSummary.asset}",
                        ),
                        InfoBloc(
                          title: "Debt",
                          value: "\$ ${state.financialSummary.debt}",
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 0.4,
                        color: Colors.grey.shade400,
                      )
                    ]),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.accountSummaries.length,
                  separatorBuilder: (context, index) => const CustomDivider(),
                  itemBuilder: (context, index) {
                    final accountBalance = state.accountSummaries[index];
                    final transactionSourceName =
                        accountBalance.transactionSource.name;
                    final balancesBySource =
                        state.financialSummary.balancesBySource;
                    final accountSummaryAmount =
                        balancesBySource[transactionSourceName];

                    final isPositiveSource = TransactionsConstants
                        .kPositiveTransactionSources
                        .contains(transactionSourceName);

                    return AccountTransactionRow(
                      account: transactionSourceName,
                      icon: accountBalance.transactionSource.icon,
                      amount: accountSummaryAmount ?? 0,
                      textColor: isPositiveSource
                          ? AppColors.incomeColor
                          : AppColors.expenseColor,
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
