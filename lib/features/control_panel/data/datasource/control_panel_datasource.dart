import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/recipe/data/models/index_recipes_response_model.dart';

class RemoteControlPanelDataSource {
  RemoteControlPanelDataSource._();
  static Future<IndexRecipesResponseModel> indexMyRecipes() async {
    final GetApi getApi = GetApi(
        uri: ApiVariables.indexUserRecipe(),
        fromJson: indexRecipesResponseModelFromJson);
    return await getApi.callRequest();
  }
}
