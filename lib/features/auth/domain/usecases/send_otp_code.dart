import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

import '../../data/models/reset_password_response_model.dart';

class SendOtpCodeUseCase
    implements UseCase<PasswordResetResponseModel, SendOtpParams> {
  final AuthRepository repository;

  SendOtpCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, PasswordResetResponseModel>> call(
      SendOtpParams body) async {
    return repository.sendResetPasswordEmail(body: body.getBody());
  }
}

class SendOtpParams implements UseCaseParams {
  final String email;

  SendOtpParams({
    required this.email,
  });

  @override
  BodyMap getBody() => {
        "email": email,
      };

  @override
  ParamsMap getParams() {
    return {};
  }
}
