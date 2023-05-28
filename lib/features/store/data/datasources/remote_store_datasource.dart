import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';

class RemoteStoreDatasource {
  Future<IndexIngredientsResponseModel> indexIngredients({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredients(),
      fromJson: indexIngredientsResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future<ShowIngredientResponseModel> showIngredient({required String id, Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.showIngredients(id: id),
      fromJson: showIngredientResponseModelFromJson,
    );
    final result = await getApi.callRequest();
    return result;
  }

  Future addToCart({Map<String, dynamic>? params}) async {
    //TODO:
    throw UnimplementedError();
  }

  Future addToWishlist({Map<String, dynamic>? params}) async {
    //TODO:
    throw UnimplementedError();
  }

  Future sendOrder({Map<String, dynamic>? params}) async {
    //TODO:
    throw UnimplementedError();
  }
}
