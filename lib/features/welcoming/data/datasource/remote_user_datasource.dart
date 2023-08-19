import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/get_api.dart';
import '../model/user_info_response_model.dart';

class RemoteUserDatasource {
  RemoteUserDatasource._();

  static Future<UserInfoResponseModel> getUserInfo() async {
    GetApi api = GetApi(
      uri: ApiVariables.getUserInfo(),
      fromJson: userInfoResponseModelFromJson,
    );
    final result = await api();
    return result;
  }
}
