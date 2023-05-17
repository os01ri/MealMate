import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';

class RemoteRecipeDatasource {
  Future<List<RecipeModel>> indexRecipes({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexRecipes(),
      fromJson: RecipeModel.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }
}
