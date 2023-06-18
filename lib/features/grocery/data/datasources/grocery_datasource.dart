import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/delete_api.dart';
import '../../../../core/unified_api/methods/get_api.dart';

import '../../../../core/models/no_response_model.dart';
import '../models/index_grocery_response_model.dart';

class GroceryDataSource {
  Future<IndexGroceryResponseModel> indexGrocery() async {
    GetApi getApi = GetApi(
        uri: ApiVariables.groceryIndex(),
        fromJson: indexGroceryResponseModelFromJson);
    final result = await getApi.callRequest();
    return result;
  }

  Future<NoResponse> deleteGroceryItem(int id) async {
    DeleteApi deleteApi = DeleteApi(
        uri: ApiVariables.groceryDelete(id), fromJson: noResponseFromJson);
    final result = await deleteApi.callRequest();
    return result;
  }
}
