import 'package:equatable/equatable.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';

class StatResponse with EquatableMixin {
  final List<ReportBreakdown> reports;

  const StatResponse({required this.reports});

  @override
  List<Object?> get props => [reports];
}
