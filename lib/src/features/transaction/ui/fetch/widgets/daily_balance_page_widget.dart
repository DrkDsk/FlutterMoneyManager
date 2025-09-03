import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_list_container.dart';

class DailyBalancePage extends StatefulWidget {
  const DailyBalancePage({
    super.key,
  });

  @override
  State<DailyBalancePage> createState() => _DailyBalancePageState();
}

class _DailyBalancePageState extends State<DailyBalancePage> {
  late TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    super.initState();
    _transactionsBloc = context.read<TransactionsBloc>();
    final monthIndex = _transactionsBloc.state.monthIndex;
    _transactionsBloc.add(LoadTransactionsByMonth(monthIndex: monthIndex));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TransactionsBloc, TransactionsListState>(
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

                    return TransactionListContainer(
                        date: date, transactions: grouped.transactions);
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
