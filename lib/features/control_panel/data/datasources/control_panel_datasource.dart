import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../../../../core/unified_api/methods/put_request.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
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
}
