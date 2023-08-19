import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/delete_api.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../../../../core/unified_api/methods/post_api.dart';
import '../models/index_ingredients_categories_response_model.dart';
import '../models/index_ingredients_response_model.dart';
import '../models/index_wishlist_items_response_model.dart';
import '../models/show_ingredient_response_model.dart';

class RemoteStoreDatasource {
  const RemoteStoreDatasource._();

  /////////////////////////
  ///ingredient category///
  /////////////////////////
  static Future<IndexIngredientCategoriesResponseModel> indexIngredientsCategories({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexIngredientsCategories(params: params),
      fromJson: indexIngredientCategoriesResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  ////////////////
  ///ingredient///
  ////////////////

  static Future<IndexIngredientsResponseModel> indexIngredients({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexIngredients(params: params),
      fromJson: indexIngredientsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<ShowIngredientResponseModel> showIngredient({required int id, ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.showIngredients(id: id),
      fromJson: showIngredientResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future placeOrder({required BodyMap body}) async {
    PostApi api = PostApi(uri: ApiVariables.placeOrder(), body: body, fromJson: noResponseFromJson);
    final result = await api();
    return result;
  }

  //////////////
  ///wishlist///
  //////////////

  static Future<IndexWishlistItemsResponseModel> indexWishlist({ParamsMap params}) async {
    GetApi api = GetApi(
      uri: ApiVariables.indexWishlist(params: params),
      fromJson: indexWishlistItemsResponseModelFromJson,
    );
    final result = await api();
    return result;
  }

  static Future<NoResponse> addToWishlist({required BodyMap body, ParamsMap params}) async {
    PostApi api = PostApi(
      uri: ApiVariables.addToWishlist(params: params),
      fromJson: noResponseFromJson,
      body: body,
    );
    final result = await api();
    return result;
  }

  static Future<NoResponse> removeFromWishlist({required int id}) async {
    DeleteApi api = DeleteApi(
      uri: ApiVariables.removeFromWishlist(id: id),
      fromJson: noResponseFromJson,
    );
    final result = await api();
    return result;
  }
}
