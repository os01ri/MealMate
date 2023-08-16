import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repositories/user_info_repository.dart';
import '../datasource/remote_user_datasource.dart';
import '../model/user_info_response_model.dart';

class UserInfoRepositoryImpl with HandlingExceptionManager implements UserInfoRepository {
  @override
  Future<Either<Failure, UserInfoResponseModel>> getUserInfo() async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteUserDatasource.getUserInfo();
      return Right(result);
    });
  }
}
