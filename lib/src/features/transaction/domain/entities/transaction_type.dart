import 'package:equatable/equatable.dart';

class TransactionType with EquatableMixin {
  final String name;
  final String type;

  const TransactionType({required this.name, required this.type});

  @override
  List<Object?> get props => [name, type];
}
