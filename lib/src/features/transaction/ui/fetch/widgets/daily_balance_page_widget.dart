import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transactions_list.dart';

class DailyBalancePage extends StatelessWidget {
  const DailyBalancePage({
    super.key,
  });

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
            const SizedBox(height: 10),
            if (state.transactions.isNotEmpty) ...[
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.transactions.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox.shrink();
                  },
                  itemBuilder: (context, index) {
                    final grouped = state.transactions[index];
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary
                                      .customOpacity(0.08),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Text(date.dayName,
                                  style: theme.textTheme.bodyMedium),
                            ),
                            const SizedBox(width: 10),
                            Text("${date.year}"),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TransactionsList(transactions: grouped.transactions),
                      ],
                    );
                  },
                ),
              ),
            ] else ...[
              const Expanded(
                  child: Center(child: Text("Sin transacciones disponibles")))
            ]
          ],
        );
      },
    );
  }
}
