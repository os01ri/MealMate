part of 'register_bloc.dart';

abstract class RegisterEvent {
  const RegisterEvent();
}

class RegisterUserEvent extends RegisterEvent {
  final RegitserUserParams params;
  RegisterUserEvent({required this.params});
}
