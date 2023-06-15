part of 'auth_cubit.dart';

enum AuthStatus { loading, success, failed, init, resend }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
final String? token;
  final String? email;
  const AuthState({
    this.status = AuthStatus.init,
    this.user, this.token, this.email});

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
          String? token,
          String? email
  }) =>
      AuthState(
        token: token ?? this.token,
        status: status ?? this.status,
        user: user ?? this.user,
        email: email ?? this.email,
      );
}
