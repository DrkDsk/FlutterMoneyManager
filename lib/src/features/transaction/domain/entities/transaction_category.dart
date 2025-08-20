import 'package:equatable/equatable.dart';

class TransactionCategory with EquatableMixin {
  final String name;
  final String icon;

  const TransactionCategory({
    required this.name,
    required this.icon,
  });

  TransactionCategory copyWith({
    String? name,
    String? icon,
  }) {
    return TransactionCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [name, icon];
}
