part of 'auth_cubit.dart';

enum AuthStatus { loading, success, failed, init, resend }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? token;

  const AuthState({
    this.status = AuthStatus.init,
    this.user,
    this.token,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? token,
  }) =>
      AuthState(
        token: token ?? this.token,
        status: status ?? this.status,
        user: user ?? this.user,
      );
}
