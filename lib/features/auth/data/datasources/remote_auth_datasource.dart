import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/post_api.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/data/models/reset_password_response_model.dart';

import '../../../../core/models/no_response_model.dart';

class RemoteAuthDataSource {
  Future<LoginResponseModel> registerUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.register(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }

  Future<LoginResponseModel> loginUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.login(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }


  Future<PasswordResetResponseModel> sendResetPasswordOTP(
      {required String email}) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.sendResetPasswordOTP(),
        body: {"email": email},
        fromJson: passwordResetResponseModelFromJson);
    return await postApi.callRequest();
  }

  Future<NoResponse> checkOTPCodeForResetPassword(
      {required String code}) async {
    PostApi postApi = PostApi(
        uri: ApiVariables.checkPasswordCode(),
        body: {"code": code},
        fromJson: noResponseFromJson);
    return await postApi.callRequest();
  }
}
