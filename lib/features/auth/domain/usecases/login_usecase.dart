import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/login_response_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponseModel, LoginUserParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponseModel>> call(LoginUserParams body) async {
    return repository.loginUser(body: body.getBody());
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
  BodyMap getBody() => {"password": password, "username": email};

  @override
  ParamsMap getParams() => {};
}
