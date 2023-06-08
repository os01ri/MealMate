import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponseModel>> registerUser(
      {required BodyMap body});

  Future<Either<Failure, User>> loginUser({required Map<String, dynamic> body});
  Future<Either<Failure, Unit>> resetPassword({required String email});
  Future<Either<Failure, Unit>> verifyCode({required String code});
  Future<Either<Failure, LoginResponseModel>> loginUser(
      {required BodyMap body});
}
