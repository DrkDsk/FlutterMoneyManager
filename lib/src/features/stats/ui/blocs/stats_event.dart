import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

sealed class StatsEvent {
  const StatsEvent();
}

class LoadStatsEvent extends StatsEvent with EquatableMixin {
  final TransactionTypEnum type;

  const LoadStatsEvent({required this.type});

  @override
  List<Object?> get props => [type];
}
