import 'package:equatable/equatable.dart';

class Transactioncategory with EquatableMixin {
  final String name;
  final String icon;

  const Transactioncategory({required this.name, required this.icon});

  @override
  List<Object?> get props => [name, icon];
}
