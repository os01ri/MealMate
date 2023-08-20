import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
import '../../data/models/follows_response_model.dart';
import '../../data/models/user_info_response_model.dart';

abstract class ControlPanelRepository {
  Future<Either<Failure, IndexRecipesResponseModel>> indexUserRecipes();
  Future<Either<Failure, UserInfoResponseModel>> getUserInfo();
  Future<Either<Failure, NoResponse>> updateUserInfo({required BodyMap body});

  Future<Either<Failure, FollowsResponseModel>> indexFollowers();
  Future<Either<Failure, FollowsResponseModel>> indexFollowings();
}
