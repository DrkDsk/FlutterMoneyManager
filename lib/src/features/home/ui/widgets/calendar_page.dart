import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/body_calendar.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_list_container.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: state.transactions.length + 1,
          separatorBuilder: (context, index) => const SizedBox.shrink(),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: kWidgetRoundedDecoration,
                child: const BodyCalendar(),
              );
            }

            final grouped = state.transactions[index - 1];
            final date = grouped.date;

            return TransactionListContainer(
              date: date,
              transactions: grouped.transactions,
            );
          },
        );
      },
    );
  }
}
