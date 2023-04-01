class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class UnauthenticatedException implements Exception {
  final String message;
  UnauthenticatedException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class EmailUsedException implements Exception {}

class PhoneNumberUsedException implements Exception {}

class OldPasswordWrongException implements Exception {}

class PasswordOrUsernameWrongException implements Exception {}

class CodeWrongException implements Exception {}

class NoPhoneNumberException implements Exception {}

class PhoneNumberNotVerifyException implements Exception {}

class UserBlockedException implements Exception {}

class UserHasOrderBeforeException implements Exception {}