import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transactions_list.dart';

class DailyBalancePage extends StatefulWidget {
  const DailyBalancePage({
    super.key,
  });

  @override
  State<DailyBalancePage> createState() => _DailyBalancePageState();
}

class _DailyBalancePageState extends State<DailyBalancePage> {
  late GetTransactionsListCubit _getTransactionsListCubit;

  @override
  void initState() {
    super.initState();
    _getTransactionsListCubit = context.read<GetTransactionsListCubit>();
    Future.microtask(() {
      _getTransactionsListCubit.getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<GetTransactionsListCubit, GetTransactionListState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Transacciones de ${state.monthName}",
              style: theme.textTheme.bodyLarge,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: state.data.length,
                separatorBuilder: (context, index) {
                  return const SizedBox.shrink();
                },
                itemBuilder: (context, index) {
                  final grouped = state.data[index];
                  final date = grouped.date;
                  final monthName = date.monthName;
                  final formattedDate = "$monthName ${date.day}";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            formattedDate,
                            style: theme.textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.onPrimary
                                    .customOpacity(0.08),
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(date.dayName,
                                style: theme.textTheme.bodyMedium),
                          ),
                          const SizedBox(width: 10),
                          const Text("2025")
                        ],
                      ),
                      SizedBox(
                          height: 300,
                          child: TransactionsList(
                              transactions: grouped.transactions)),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
