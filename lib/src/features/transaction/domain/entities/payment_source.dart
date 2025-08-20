import 'package:equatable/equatable.dart';

class PaymentSource with EquatableMixin {
  final String name;
  final String icon;

  const PaymentSource({required this.name, required this.icon});

  @override
  List<Object?> get props => [name, icon];
}
