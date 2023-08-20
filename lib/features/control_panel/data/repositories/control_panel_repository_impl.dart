import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
import '../../domain/repositories/control_panel_repository.dart';
import '../datasources/control_panel_datasource.dart';
import '../models/follows_response_model.dart';
import '../models/user_info_response_model.dart';

class ControlPanelRepositoryImpl with HandlingExceptionManager implements ControlPanelRepository {
  @override
  Future<Either<Failure, IndexRecipesResponseModel>> indexUserRecipes() {
    return wrapHandling(tryCall: () async {
      final result = await RemoteControlPanelDataSource.indexMyRecipes();
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, UserInfoResponseModel>> getUserInfo() async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteControlPanelDataSource.getUserInfo();
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, NoResponse>> updateUserInfo({required BodyMap body}) async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteControlPanelDataSource.updateUserInfo(body: body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, FollowsResponseModel>> indexFollowers() async {
    return wrapHandling(tryCall: () async {
      final result = await RemoteControlPanelDataSource.indexFollowers();
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, FollowsResponseModel>> indexFollowings() {
    return wrapHandling(tryCall: () async {
      final result = await RemoteControlPanelDataSource.indexFollowings();
      return Right(result);
    });
  }
}
