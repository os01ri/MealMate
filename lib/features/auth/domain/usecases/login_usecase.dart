import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class LoginUseCase implements UseCase<User, LoginUserParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(LoginUserParams body) async {
    return authRepository.loginUser(body: body.getBody());
  }
}

class LoginUserParams implements UseCaseParams {
  final String email;
  final String password;

  LoginUserParams({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> getBody() => {"password": password, "email": email};

  @override
  Map<String, dynamic> getParams() {
    return {};
  }
}
