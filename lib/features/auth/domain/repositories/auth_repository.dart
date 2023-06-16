import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/data/models/reset_password_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseModel>> registerUser({required BodyMap body});

  Future<Either<Failure, LoginResponseModel>> loginUser({required BodyMap body});

  Future<Either<Failure, PasswordResetResponseModel>> sendResetPasswordEmail({required BodyMap body});

  Future<Either<Failure, PasswordResetResponseModel>> checkOTPCode({required BodyMap body, required bool isRegister});

  Future<Either<Failure, NoResponse>> changePassword({required BodyMap body});
}
