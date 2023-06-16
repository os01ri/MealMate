import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/delete_api.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/core/unified_api/methods/post_api.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_categories_response_model.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/index_wishlist_items_response_model.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';

class RemoteStoreDatasource {
  const RemoteStoreDatasource._();

  /////////////////////////
  ///ingredient category///
  /////////////////////////
  static Future<IndexIngredientCategoriesResponseModel> indexIngredientsCategories({ParamsMap params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredientsCategories(queryParameters: params),
      fromJson: indexIngredientCategoriesResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  ////////////////
  ///ingredient///
  ////////////////

  static Future<IndexIngredientsResponseModel> indexIngredients({ParamsMap params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredients(queryParameters: params),
      fromJson: indexIngredientsResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  static Future<ShowIngredientResponseModel> showIngredient({required String id, ParamsMap params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.showIngredients(id: id),
      fromJson: showIngredientResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  static Future placeOrder({required BodyMap body}) async {
    PostApi postApi = PostApi(uri: ApiVariables.placeOrder(), body: body, fromJson: noResponseFromJson);
    final result = await postApi.callRequest();
    return result;
  }

  //////////////
  ///wishlist///
  //////////////

  static Future<IndexWishlistItemsResponseModel> indexWishlist({ParamsMap params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexWishlist(queryParameters: params),
      fromJson: indexWishlistItemsResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  static Future<NoResponse> addToWishlist({required BodyMap body, ParamsMap params}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.addToWishlist(queryParameters: params),
      fromJson: noResponseFromJson,
      body: body,
    );
    final result = await postApi.callRequest();
    return result;
  }

  static Future<NoResponse> removeFromWishlist({required String id}) async {
    DeleteApi deleteApi = DeleteApi(
      uri: ApiVariables.removeFromWishlist(id: id),
      fromJson: noResponseFromJson,
    );
    final result = await deleteApi.callRequest();
    return result;
  }
}
