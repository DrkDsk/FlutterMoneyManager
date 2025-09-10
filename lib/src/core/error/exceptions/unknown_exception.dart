import 'package:equatable/equatable.dart';

class UnknownException with EquatableMixin implements Exception {
  final String message;

  UnknownException(
      {this.message = "Ha ocurrido un error inesperado, intente más tarde."});

  @override
  List<Object?> get props => [message];
}
