part of 'login_bloc.dart';

enum LoginStatus { loading, success, failed, init }

class LoginState {
  final LoginStatus status;
  final User? user;
  const LoginState({
    this.status = LoginStatus.init,
    this.user,
  });
  LoginState copyWith({LoginStatus? status, User? user}) =>
      LoginState(status: status ?? this.status, user: user ?? this.user);
}
