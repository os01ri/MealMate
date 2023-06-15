import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase
    implements UseCase<NoResponse, ChangePasswordParams> {
  final AuthRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(ChangePasswordParams body) async {
    return repository.changePassword(body: body.getBody());
  }
}

class ChangePasswordParams implements UseCaseParams {
  final String newPassword;

  ChangePasswordParams({
    required this.newPassword,
  });

  @override
  BodyMap getBody() => {
        "password": newPassword,
      };

  @override
  ParamsMap getParams() {
    return {};
  }
}
