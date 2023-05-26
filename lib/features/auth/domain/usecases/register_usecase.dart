import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class RegisterUseCase implements UseCase<User, RegisterUserParams> {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(RegisterUserParams body) async {
    return authRepository.registerUser(body: body.getBody());
  }
}

class RegisterUserParams implements UseCaseParams {
  final String email;
  final String password;
  final String userName;

  RegisterUserParams({
    required this.email,
    required this.userName,
    required this.password,
  });

  @override
  Map<String, dynamic> getBody() => {
        "name": userName,
        "password": password,
        "email": email,
      };

  @override
  Map<String, dynamic> getParams() {
    return {};
  }
}
