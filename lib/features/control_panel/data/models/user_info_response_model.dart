import 'dart:convert';

import '../../../auth/data/models/user_model.dart';

UserInfoResponseModel userInfoResponseModelFromJson(String str) => UserInfoResponseModel.fromJson(json.decode(str));

String userInfoResponseModelToJson(UserInfoResponseModel data) => json.encode(data.toJson());

class UserInfoResponseModel {
  final String? message;
  final bool? success;
  final UserModel? data;

  UserInfoResponseModel({
    this.message,
    this.success,
    this.data,
  });

  UserInfoResponseModel copyWith({
    String? message,
    bool? success,
    UserModel? data,
  }) =>
      UserInfoResponseModel(
        message: message ?? this.message,
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) => UserInfoResponseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}
 