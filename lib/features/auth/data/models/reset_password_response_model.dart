// To parse this JSON data, do
//
//     final passwordResetResponseModel = passwordResetResponseModelFromJson(jsonString);

import 'dart:convert';

PasswordResetResponseModel passwordResetResponseModelFromJson(String str) =>
    PasswordResetResponseModel.fromJson(json.decode(str));

String passwordResetResponseModelToJson(PasswordResetResponseModel data) =>
    json.encode(data.toJson());

class PasswordResetResponseModel {
  final String? message;
  final Data? data;
  final bool? success;

  PasswordResetResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) =>
      PasswordResetResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}

class Data {
  final String? refreshToken;
  final String? token;
  final int? expiredAt;

  Data({
    this.refreshToken,
    this.token,
    this.expiredAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        refreshToken: json["refreshToken"],
        token: json["token"],
        expiredAt: json["expired_at"],
      );

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
        "token": token,
        "expired_at": expiredAt,
      };
}
