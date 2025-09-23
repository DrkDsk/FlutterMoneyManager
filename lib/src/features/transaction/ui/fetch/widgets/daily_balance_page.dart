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
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    final monthIndex = _transactionsBloc.state.monthIndex;
    _transactionsBloc.add(LoadTransactionsByMonth(month: monthIndex));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (context, state) {
        if (state.transactions.isEmpty) {
          return const Center(child: Text("Sin transacciones disponibles"));
        }

        return ListView.separated(
          itemCount: state.transactions.length + 1,
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                "Transacciones de ${state.monthName}",
                style: theme.textTheme.bodyLarge,
              );
            }

            final grouped = state.transactions[index - 1];
            final date = grouped.date;

            return TransactionListContainer(
                date: date, transactions: grouped.transactions);
          },
        );
      },
    );
  }
}
