import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> registerUser({required Map<String, dynamic> body});

  Future<Either<Failure, User>> loginUser({required Map<String, dynamic> body});
}
