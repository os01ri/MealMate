import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<LoginResponseModel, RegisterUserParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(RegisterUserParams body) async {
    return repository.registerUser(body: body.getBody());
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
  BodyMap getBody() => {
        "name": userName,
        "password": password,
        "email": email,
      };

  @override
  ParamsMap getParams() {
    return {};
  }
}
