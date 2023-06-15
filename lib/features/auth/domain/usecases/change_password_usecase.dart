import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ChangePasswordUseCase implements UseCase<NoResponse, ChangePasswordParams> {
  final AuthRepository repository;

  const ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(ChangePasswordParams body) async {
    return repository.changePassword(body: body.getBody());
  }
}

class ChangePasswordParams implements UseCaseParams {
  final String newPassword;

  const ChangePasswordParams({required this.newPassword});

  @override
  BodyMap getBody() => {"password": newPassword};

  @override
  ParamsMap getParams() => {};
}
