import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/shared/builders/calendar/custom_calendar_builder.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/header_calendar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';

class BodyCalendar extends StatefulWidget {
  const BodyCalendar({super.key});

  @override
  State<BodyCalendar> createState() => _BodyCalendarState();
}

class _BodyCalendarState extends State<BodyCalendar> {
  late TransactionsBloc _transactionsBloc;
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    super.initState();
    _transactionsBloc = context.read<TransactionsBloc>();
    _calendarBloc = context.read<CalendarBloc>();
  }

  void onLeftTap({required DateTime date}) {
    final focusedDate = date.subtract(const Duration(days: 30));

    _calendarBloc.add(UpdateFocusedDate(focusedDate: focusedDate));

    final monthIndex = _transactionsBloc.prevIndex();

    if (monthIndex == null) return;

    _transactionsBloc.add(UpdateMonth(monthIndex: monthIndex));
    _transactionsBloc.add(LoadTransactionsByMonth(monthIndex: monthIndex));
  }

  void onRighTap({required DateTime date}) {
    final focusedDate = date.add(const Duration(days: 30));
    _calendarBloc.add(UpdateFocusedDate(focusedDate: focusedDate));

    final monthIndex = _transactionsBloc.nextIndex();

    if (monthIndex == null) return;

    _transactionsBloc.add(UpdateMonth(monthIndex: monthIndex));
    _transactionsBloc.add(LoadTransactionsByMonth(monthIndex: monthIndex));
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    _calendarBloc.add(UpdateFocusedDate(focusedDate: focusedDate));
    _calendarBloc.add(UpdateSelectedDate(selectedDate: selectedDate));
    _transactionsBloc.add(FilterTransactionsByDay(selectedDate));
  }

  void onPageChanged(DateTime focusedDay) {
    final titleCalendar = "${focusedDay.monthName} ${focusedDay.year}";
    final monthIndex = focusedDay.month;
    _calendarBloc.add(UpdateTitleCalendar(titleCalendar: titleCalendar));
    _calendarBloc.add(UpdateFocusedDate(focusedDate: focusedDay));
    _transactionsBloc.add(UpdateMonth(monthIndex: monthIndex));
    _transactionsBloc.add(LoadTransactionsByMonth(monthIndex: monthIndex));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return Column(
          children: [
            HeaderCalendar(
                titleCalendar: state.titleCalendar,
                onLeftTap: () => onLeftTap(date: state.focusedDate),
                onRightTap: () => onRighTap(date: state.focusedDate)),
            const SizedBox(height: 20),
            TableCalendar(
              headerVisible: false,
              focusedDay: state.focusedDate,
              firstDay: state.firstDate,
              lastDay: state.lastDate,
              rowHeight: 60,
              selectedDayPredicate: (day) {
                return isSameDay(day, state.selectedDate);
              },
              onDayLongPressed: (selectedDay, focusedDay) {},
              calendarFormat: CalendarFormat.month,
              onDaySelected: onDaySelected,
              onPageChanged: onPageChanged,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) {
                  return date.dayName.substring(0, 3);
                },
                weekdayStyle: TextStyle(
                    fontSize: 15.0, color: theme.colorScheme.secondary),
                weekendStyle: TextStyle(
                    fontSize: 15.0,
                    color: theme.colorScheme.secondary.customOpacity(0.45)),
              ),
              calendarBuilders: const CalendarBuilders(
                todayBuilder: CustomCalendarBuilder.todayBuilder,
                defaultBuilder: CustomCalendarBuilder.defaultBuilder,
                outsideBuilder: CustomCalendarBuilder.outsideBuilder,
                selectedBuilder: CustomCalendarBuilder.selectedBuilder,
              ),
            )
          ],
        );
      },
    );
  }
}
