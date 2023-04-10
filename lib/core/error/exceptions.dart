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

class PasswordOrUsernameWrongException implements Exception {}

class UserBlockedException implements Exception {}
