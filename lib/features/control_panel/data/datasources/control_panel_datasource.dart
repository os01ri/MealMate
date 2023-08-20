import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/delete_api.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../../../../core/unified_api/methods/post_api.dart';
import '../../../../core/unified_api/methods/put_request.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
import '../models/follows_response_model.dart';
import '../models/restrictions_response_model.dart';
import '../models/user_info_response_model.dart';

class RemoteControlPanelDataSource {
  const RemoteControlPanelDataSource._();

  static Future<IndexRecipesResponseModel> indexMyRecipes() async {
    final GetApi api = GetApi(
      uri: ApiVariables.indexUserRecipe(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    return await api();
  }

  static Future<UserInfoResponseModel> getUserInfo() async {
    GetApi api = GetApi(
      uri: ApiVariables.getUserInfo(),
      fromJson: userInfoResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<NoResponse> updateUserInfo({required BodyMap body}) async {
    final PutApi api = PutApi(
      uri: ApiVariables.updateUserInfo(),
      body: body,
      fromJson: noResponseFromJson,
    );
    return await api();
  }

  static Future<FollowsResponseModel> indexFollowers() async {
    GetApi api = GetApi(
      uri: ApiVariables.indexFollowers(),
      fromJson: followsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<FollowsResponseModel> indexFollowings() async {
    GetApi api = GetApi(
      uri: ApiVariables.indexFollowings(),
      fromJson: followsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<RestrictionsResponseModel> indexRestrictions() async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRestrictions(),
      fromJson: restrictionsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<NoResponse> addRestrictions(BodyMap bodyMap) async {
    PostApi api = PostApi(
      uri: ApiVariables.addRestriction(),
      fromJson: noResponseFromJson,
      body: bodyMap,
    );
    final result = await api();
    return result;
  }

  static Future<NoResponse> deleteRestrictions({required int id}) async {
    DeleteApi api = DeleteApi(
      uri: ApiVariables.deleteRestriction(id: id),
      fromJson: noResponseFromJson,
    );
    final result = await api();
    return result;
  }
}
