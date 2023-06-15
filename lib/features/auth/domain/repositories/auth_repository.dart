import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/reset_password_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseModel>> registerUser({required BodyMap body});

  Future<Either<Failure, LoginResponseModel>> loginUser({required BodyMap body});

  Future<Either<Failure, PasswordResetResponseModel>> sendResetPasswordEmail({required BodyMap body});

  Future<Either<Failure, PasswordResetResponseModel>> checkOTPCode({required BodyMap body, required bool isRegister});

  Future<Either<Failure, NoResponse>> changePassword({required BodyMap body});
}
