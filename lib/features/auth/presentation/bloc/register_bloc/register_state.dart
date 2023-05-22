part of 'register_bloc.dart';

enum RegisterStatus { loading, success, failed, init }

class RegisterState {
  final RegisterStatus status;
  final User? user;
  const RegisterState({this.status = RegisterStatus.init, this.user});
  RegisterState copyWith({RegisterStatus? status, User? user}) =>
      RegisterState(status: status ?? this.status, user: user ?? this.user);
}
