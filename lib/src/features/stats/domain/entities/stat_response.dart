import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';

class StatResponse with EquatableMixin {
  final List<StatBreakdown> stats;

  const StatResponse({required this.stats});

  @override
  List<Object?> get props => [stats];
}
