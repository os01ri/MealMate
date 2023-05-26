part of 'auth_cubit.dart';

enum AuthStatus { loading, success, failed, init }

class AuthState {
  final AuthStatus status;
  final User? user;

  const AuthState({
    this.status = AuthStatus.init,
    this.user,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
      );
}
