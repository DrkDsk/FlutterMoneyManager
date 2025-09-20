import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/stat_response.dart';

class StatsState with EquatableMixin {
  final StatResponse data;
  final TransactionTypEnum type;

  const StatsState({required this.data, required this.type});

  factory StatsState.initial() {
    return const StatsState(
        data: StatResponse(stats: []), type: TransactionTypEnum.income);
  }

  StatsState copyWith({StatResponse? data, TransactionTypEnum? type}) {
    return StatsState(data: data ?? this.data, type: type ?? this.type);
  }

  @override
  List<Object?> get props => [data, type];
}
