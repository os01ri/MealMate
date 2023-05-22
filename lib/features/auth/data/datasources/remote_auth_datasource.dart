import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/post_api.dart';
import 'package:mealmate/features/auth/data/models/user_model.dart';
import 'package:mealmate/features/auth/domain/entities/user.dart';

class RemoteAuthDataSource {
  Future<User> registerUser({required Map<String, dynamic> params}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.register(),
      body: params,
      fromJson: userModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }
}
