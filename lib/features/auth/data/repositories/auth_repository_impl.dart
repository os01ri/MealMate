import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:mealmate/features/auth/data/models/user_model.dart';
import 'package:mealmate/features/auth/domain/entities/user.dart';
import 'package:mealmate/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementaion
    with HandlingExceptionManager
    implements AuthRepository {
  final authDatasource = RemoteAuthDataSource();
  @override
  Future<Either<Failure, User>> registerUser(
      {required Map<String, dynamic> body}) async {
    return wrapHandling(tryCall: () async {
      final result = await authDatasource.registerUser(params: body);
      return Right(result);
    });
  }
}
