import 'package:equatable/equatable.dart';

sealed class TransactionsEvent {
  const TransactionsEvent();
}

class LoadTransactionsByMonth extends TransactionsEvent with EquatableMixin {
  final int? monthIndex;
  const LoadTransactionsByMonth({this.monthIndex});

  @override
  List<Object?> get props => [monthIndex];
}

class FilterTransactionsByDay extends TransactionsEvent with EquatableMixin {
  final DateTime selectedDay;
  FilterTransactionsByDay(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

class UpdateMonth extends TransactionsEvent with EquatableMixin {
  final int monthIndex;

  const UpdateMonth({required this.monthIndex});

  @override
  List<Object?> get props => [monthIndex];
}
