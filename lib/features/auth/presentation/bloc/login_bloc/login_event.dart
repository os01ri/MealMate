part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginUserEvent extends LoginEvent {
  final LoginUserParams body;

  LoginUserEvent({required this.body});
}
