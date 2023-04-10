import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);
  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class UnauthenticatedFailure extends Failure {
  const UnauthenticatedFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(String message) : super(message);
}

class EmailUsedFailure extends Failure {
  const EmailUsedFailure(String message) : super(message);
}

class PhoneNumberUsedFailure extends Failure {
  const PhoneNumberUsedFailure(String message) : super(message);
}

class PasswordOrUsernameFailure extends Failure {
  const PasswordOrUsernameFailure(String message) : super(message);
}

class UserBlockedFailure extends Failure {
  const UserBlockedFailure(String message) : super(message);
}
