import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/auth_repository.dart';

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
  final String name;
  final String userName;

  RegisterUserParams({
    required this.email,
    required this.userName,
    required this.name,
    required this.password,
  });

  @override
  BodyMap getBody() => {
        "username": userName,
        "name": name,
        "password": password,
        "email": email,
      };

  @override
  ParamsMap getParams() {
    return {};
  }
}
