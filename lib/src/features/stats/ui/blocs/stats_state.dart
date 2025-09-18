import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/stat_response.dart';

class StatsState with EquatableMixin {
  final StatResponse data;

  const StatsState({required this.data});

  @override
  List<Object?> get props => [data];

  factory StatsState.initial() {
    return const StatsState(data: StatResponse(stats: []));
  }

  StatsState copyWith({StatResponse? data}) {
    return StatsState(data: data ?? this.data);
  }
}
