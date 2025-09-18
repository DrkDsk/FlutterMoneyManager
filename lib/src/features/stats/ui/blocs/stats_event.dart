import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

sealed class StatsEvent {
  const StatsEvent();
}

class LoadStatsEvent extends StatsEvent with EquatableMixin {
  final TransactionTypEnum type;
  final int? year;
  final int? month;

  const LoadStatsEvent({required this.type, this.month, this.year});

  @override
  List<Object?> get props => [type, month, year];
}

/*class UpdateTabIndex extends StatsEvent with EquatableMixin {

}*/
