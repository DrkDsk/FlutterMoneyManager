import 'package:equatable/equatable.dart';

class StatBreakdown with EquatableMixin {
  final String source;
  final int amount;
  final double percent;

  const StatBreakdown({
    required this.source,
    required this.amount,
    required this.percent,
  });

  @override
  List<Object?> get props => [
        source,
        amount,
        percent,
      ];
}
