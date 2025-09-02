import 'package:equatable/equatable.dart';

class TransactionType with EquatableMixin {
  final String name;

  const TransactionType({required this.name});

  @override
  List<Object?> get props => [name];
}
