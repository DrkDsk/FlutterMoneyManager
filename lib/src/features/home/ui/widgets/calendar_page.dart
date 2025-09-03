import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/body_calendar.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_list_container.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              decoration: kWidgetRoundedDecoration,
              child: const BodyCalendar()),
          const SizedBox(height: 20),
          BlocBuilder<TransactionsBloc, TransactionsListState>(
            builder: (context, state) {
              if (state.transactions.isEmpty) {
                return const Center(
                    child: Text("Sin transacciones disponibles"));
              }

              return ListView.separated(
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
              );
            },
          )
        ],
      ),
    );
  }
}
