import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({
    super.key,
  });

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
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

    return ListView.separated(
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.colorScheme.onSecondary.customOpacity(0.10),
          ),
          child: TransactionListItem(
            amuount: 40,
            date: "Aug 16",
            weekDay: "Monday",
            source: "Salary",
            transactionSource: "DEbit card",
          ),
        );
      },
      separatorBuilder: (_, index) => const Divider(
        color: Colors.grey,
        thickness: 0.5,
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  const TransactionListItem(
      {super.key,
      required this.date,
      required this.weekDay,
      required this.amuount,
      required this.source,
      required this.transactionSource});

  final String date;
  final String weekDay;
  final int amuount;
  final String source;
  final String transactionSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  date,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary.customOpacity(0.08),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(weekDay, style: theme.textTheme.bodyMedium),
                )
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green.shade200),
                  child: Icon(Icons.money,
                      size: 20, color: theme.colorScheme.primary),
                ),
                const SizedBox(width: 8),
                Text(
                  source,
                  style: theme.textTheme.bodyMedium,
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "\$ $amuount",
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.incomeColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  transactionSource,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
