import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/store/data/models/ingredient_model.dart';

class RemoteStoreDatasource {
  Future<IngredientModelResponse> indexIngredients({Map<String, dynamic>? params}) async {
    GetApi getApi = GetApi(
      uri: ApiVariables.indexIngredients(),
      fromJson: IngredientModelResponse.fromRawJson,
    );
    final result = await getApi.callRequest();
    return result;
  }
}
