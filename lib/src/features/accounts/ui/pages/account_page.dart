import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      scrollDirection: Axis.vertical,
      child: Column(
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
                      value: "\$ 0.00",
                      titleStyle: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InfoBloc(
                      title: "Total Assets",
                      value: "\$ 0.00",
                    ),
                    InfoBloc(
                      title: "Debt",
                      value: "\$ 0.00",
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.accountBalances.length,
                separatorBuilder: (context, index) => const CustomDivider(),
                itemBuilder: (context, index) {
                  final accountBalance = state.accountBalances[index];

                  return AccountTransactionRow(
                    account: accountBalance.transactionSource.name,
                    icon: accountBalance.transactionSource.icon,
                    amount: accountBalance.amount,
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
