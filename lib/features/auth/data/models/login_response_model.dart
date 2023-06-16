import 'dart:convert';

import 'package:mealmate/features/auth/data/models/user_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());


class LoginResponseModel {
  final bool? success;
  final String? message;
  final UserModel? data;

  const LoginResponseModel({
    this.success,
    this.message,
    this.data,
  });

  LoginResponseModel copyWith({
    bool? success,
    String? message,
    UserModel? data,
  }) =>
      LoginResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}
