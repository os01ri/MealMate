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

class ParentCodeFailure extends Failure {
  const ParentCodeFailure(super.message);
}

class EmailUsedFailure extends Failure {
  const EmailUsedFailure(String message) : super(message);
}

class PhoneNumberUsedFailure extends Failure {
  const PhoneNumberUsedFailure(String message) : super(message);
}

class OldPasswordWrongFailure extends Failure {
  const OldPasswordWrongFailure(String message) : super(message);
}

class PasswordOrUsernameFailure extends Failure {
  const PasswordOrUsernameFailure(String message) : super(message);
}

class CodeWrongFailure extends Failure {
  const CodeWrongFailure(String message) : super(message);
}

class NoPhoneNumberFailure extends Failure {
  const NoPhoneNumberFailure(String message) : super(message);
}

class PhoneNumberNotVerifyFailure extends Failure {
  const PhoneNumberNotVerifyFailure(String message) : super(message);
}

class UserBlockedFailure extends Failure {
  const UserBlockedFailure(String message) : super(message);
}

class UserHasOrderBeforeFailure extends Failure {
  const UserHasOrderBeforeFailure(String message) : super(message);
}
