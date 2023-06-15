import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/data/models/reset_password_response_model.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with HandlingExceptionManager implements AuthRepository {
  @override
  Future<Either<Failure, LoginResponseModel>> registerUser({required BodyMap body}) async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteAuthDataSource.registerUser(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser({required BodyMap body}) async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteAuthDataSource.loginUser(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, PasswordResetResponseModel>> checkOTPCode({
    required BodyMap body,
    required bool isRegister,
  }) {
    return wrapHandling(tryCall: () async {
      final result = isRegister
          ? await RemoteAuthDataSource.verifyAccount(body: body)
          : await RemoteAuthDataSource.checkOTPCodeForResetPassword(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, PasswordResetResponseModel>> sendResetPasswordEmail({required BodyMap body}) {
    return wrapHandling(tryCall: () async {
      final result = await RemoteAuthDataSource.sendResetPasswordOTP(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, NoResponse>> changePassword({required BodyMap body}) {
    return wrapHandling(tryCall: () async {
      final result = await RemoteAuthDataSource.changePassword(body: body);
      return Right(result);
    });
  }
}
