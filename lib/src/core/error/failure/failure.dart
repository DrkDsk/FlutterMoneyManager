import 'package:equatable/equatable.dart';

abstract interface class Failure {
  final String message;

  const Failure([this.message = ""]);
}

class CacheFailure extends Failure {}

class UnexpectedFailure extends Failure {}

class GenericFailure extends Failure with EquatableMixin {
  GenericFailure([super.message]);

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure with EquatableMixin {
  ServerFailure([super.message]);

  @override
  List<Object?> get props => [message];
}
