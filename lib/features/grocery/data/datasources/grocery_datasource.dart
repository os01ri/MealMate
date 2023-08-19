import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/delete_api.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../models/index_grocery_response_model.dart';

class GroceryDataSource {
  Future<IndexGroceryResponseModel> indexGrocery() async {
    GetApi api = GetApi(uri: ApiVariables.groceryIndex(), fromJson: indexGroceryResponseModelFromJson);
    final result = await api();
    return result;
  }

  Future<NoResponse> deleteGroceryItem(int id) async {
    DeleteApi api = DeleteApi(uri: ApiVariables.groceryDelete(id), fromJson: noResponseFromJson);
    final result = await api();
    return result;
  }
}
