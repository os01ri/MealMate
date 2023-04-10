import 'dart:convert';

import 'package:http/http.dart';

import '../error/exceptions.dart';

mixin HandlingExceptionRequest {
  Exception getException({required Response response}) {
    final String message = json.decode(response.body)['message'];

    if (response.statusCode == 401) return UnauthenticatedException(message);
    if (response.statusCode == 422) return ValidationException(message);
    if (response.statusCode == 413) return EmailUsedException();
    if (response.statusCode == 200) return PasswordOrUsernameWrongException();
    if (response.statusCode == 415) return PhoneNumberUsedException();
    if (response.statusCode == 420) return UserBlockedException();

    return ServerException(message);
  }
}
