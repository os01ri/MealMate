import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl with HandlingExceptionManager implements AuthRepository {
  final _datasource = RemoteAuthDataSource();

  @override
  Future<Either<Failure, LoginResponseModel>> registerUser({required BodyMap body}) async {
    return wrapHandling(tryCall: () async {
      final result = await _datasource.registerUser(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, LoginResponseModel>> loginUser({required BodyMap body}) async {
    return wrapHandling(tryCall: () async {
      final result = await _datasource.loginUser(body: body);
      return Right(result);
    });
  }
}
