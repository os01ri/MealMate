import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/get_api.dart';
import 'package:mealmate/features/profile/data/model/show_user_model.dart';

class RemoteProfileDataSource {
  Future<ShowUserModelResponse> showUser(int id) async {
    final getApi = GetApi(
        uri: ApiVariables.showProfileInfo(id),
        fromJson: showUserModelResponseFromJson);
    final result = await getApi.call();
    return result;
  }
}
