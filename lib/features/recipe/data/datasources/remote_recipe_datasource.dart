import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../../../../core/unified_api/methods/post_api.dart';
import '../models/index_recipes_response_model.dart';
import '../models/show_recipe_response_model.dart';

class RemoteRecipeDatasource {
  const RemoteRecipeDatasource._();

  static Future<IndexRecipesResponseModel> indexRecipes({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRecipes(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<IndexRecipesResponseModel> indexRecipesForUser({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRecipesForUser(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<IndexRecipesResponseModel> indexRecipesByFollowings({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRecipesByFollowings(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<IndexRecipesResponseModel> indexRecipesMostOrdered({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRecipesMostOrdered(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<IndexRecipesResponseModel> indexRecipesTrending({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexRecipesTrending(),
      fromJson: indexRecipesResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<ShowRecipeResponseModel> showRecipe(int id) async {
    GetApi api = GetApi(
      uri: ApiVariables.showRecipe(id),
      fromJson: showRecipeResponseModelFromJson,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<NoResponse> addRecipe(BodyMap body) async {
    PostApi api = PostApi(
      uri: ApiVariables.addRecipe(),
      fromJson: noResponseFromJson,
      body: body,
    );
    final result = await api.callRequest();
    return result;
  }

  static Future<NoResponse> cookRecipe(BodyMap body) async {
    PostApi api = PostApi(
      uri: ApiVariables.cookRecipe(),
      fromJson: noResponseFromJson,
      body: body,
    );
    final result = await api.callRequest();
    return result;
  }
  
  static Future<NoResponse> rateRecipe(BodyMap body) async {
    PostApi api = PostApi(
      uri: ApiVariables.rateRecipe(),
      fromJson: noResponseFromJson,
      body: body,
    );
    final result = await api.callRequest();
    return result;
  }
}
