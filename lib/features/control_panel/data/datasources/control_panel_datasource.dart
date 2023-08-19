import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/recipe/data/models/index_recipes_response_model.dart';

class RemoteControlPanelDataSource {
  const RemoteControlPanelDataSource._();
  static Future<IndexRecipesResponseModel> indexMyRecipes() async {
    final GetApi api = GetApi(uri: ApiVariables.indexUserRecipe(), fromJson: indexRecipesResponseModelFromJson);
    return await api();
  }
}
