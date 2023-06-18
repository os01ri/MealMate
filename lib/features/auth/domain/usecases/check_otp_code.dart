import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/reset_password_response_model.dart';
import '../repositories/auth_repository.dart';

class CheckOtpCodeUseCase implements UseCase<PasswordResetResponseModel, CheckOtpParams> {
  final AuthRepository repository;

  const CheckOtpCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, PasswordResetResponseModel>> call(CheckOtpParams body) async {
    return repository.checkOTPCode(body: body.getBody(), isRegister: body.isRegister);
  }
}

class CheckOtpParams implements UseCaseParams {
  final String code;
  final bool isRegister;

  const CheckOtpParams({required this.code, required this.isRegister});

  @override
  BodyMap getBody() => {"code": code};

  @override
  ParamsMap getParams() => {};
}
