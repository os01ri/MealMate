import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/unified_api/api_variables.dart';
import 'package:mealmate/core/unified_api/methods/post_api.dart';
import 'package:mealmate/core/unified_api/methods/put_request.dart';
import 'package:mealmate/features/auth/data/models/login_response_model.dart';
import 'package:mealmate/features/auth/data/models/reset_password_response_model.dart';

class RemoteAuthDataSource {
  const RemoteAuthDataSource._();

  static Future<LoginResponseModel> registerUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.register(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }

  static Future<LoginResponseModel> loginUser({required BodyMap body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.login(),
      body: body,
      fromJson: loginResponseModelFromJson,
    );
    final result = await postApi.callRequest();
    return result;
  }

  static Future<PasswordResetResponseModel> sendResetPasswordOTP({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.sendResetPasswordOTP(),
      body: body,
      fromJson: passwordResetResponseModelFromJson,
    );
    return await postApi.callRequest();
  }

  static Future<PasswordResetResponseModel> checkOTPCodeForResetPassword({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.checkPasswordCode(),
      body: body,
      fromJson: passwordResetResponseModelFromJson,
    );
    return await postApi.callRequest();
  }

  static Future<PasswordResetResponseModel> verifyAccount({required Map<String, dynamic> body}) async {
    PostApi postApi = PostApi(
      uri: ApiVariables.verifyAccount(),
      body: body,
      fromJson: passwordResetResponseModelFromJson,
    );
    return await postApi.callRequest();
  }

  static Future<NoResponse> changePassword({required Map<String, dynamic> body}) async {
    PutApi putApi = PutApi(
      uri: ApiVariables.changePassword(),
      body: body,
      fromJson: noResponseFromJson,
    );
    return await putApi.callRequest();
  }
}
