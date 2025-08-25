import 'package:equatable/equatable.dart';

class TransactionSource with EquatableMixin {
  final String name;
  final String icon;

  const TransactionSource({required this.name, required this.icon});

  @override
  List<Object?> get props => [name, icon];
}
