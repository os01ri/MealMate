import '../../../../core/helper/type_defs.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../models/recipe_model.dart';

class RemoteRecipeDatasource {
  Future<List<RecipeModel>> indexRecipes({ParamsMap params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexRecipes(),
      fromJson: RecipeModel.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }
}
