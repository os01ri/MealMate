import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/profile/data/datasource/remote_profile_datasource.dart';
import 'package:mealmate/features/profile/data/model/show_user_model.dart';

import '../../domain/repository/profile_repository.dart';

class ProfileRepoImpl
    with HandlingExceptionManager
    implements ProfileRepository {
  @override
  Future<Either<Failure, ShowUserModelResponse>> showUserInfo(int id) {
    return wrapHandling(tryCall: () async {
      return Right(await RemoteProfileDataSource().showUser(id));
    });
  }
}
