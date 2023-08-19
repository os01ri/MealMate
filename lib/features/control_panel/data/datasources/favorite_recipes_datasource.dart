import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/delete_api.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../../../../core/unified_api/methods/post_api.dart';
import '../models/favorite_recipes_response_model.dart';

class RemoteFavoriteRecipesDataSource {
  const RemoteFavoriteRecipesDataSource._();

  static Future<FavoriteRecipesResponseModel> indexFavoriteRecipes() async {
    final GetApi api = GetApi(
      uri: ApiVariables.indexFavoriteRecipes(),
      fromJson: favoriteRecipesResponseModelFromJson,
    );
    return await api();
  }

  static Future<NoResponse> addFavoriteRecipe({required BodyMap body}) async {
    final PostApi api = PostApi(
      uri: ApiVariables.addFavoriteRecipe(),
      fromJson: noResponseFromJson,
      body: body,
    );
    return await api();
  }

  static Future<NoResponse> deleteFavoriteRecipe({required int id}) async {
    final DeleteApi api = DeleteApi(
      uri: ApiVariables.removeFavoriteRecipe(id: id),
      fromJson: noResponseFromJson,
    );
    return await api();
  }
}
