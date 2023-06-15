import 'dart:convert';

PasswordResetResponseModel passwordResetResponseModelFromJson(String str) =>
    PasswordResetResponseModel.fromJson(json.decode(str));

String passwordResetResponseModelToJson(PasswordResetResponseModel data) => json.encode(data.toJson());

class PasswordResetResponseModel {
  final String? message;
  final _Data? data;
  final bool? success;

  const PasswordResetResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory PasswordResetResponseModel.fromJson(Map<String, dynamic> json) => PasswordResetResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : _Data.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}

class _Data {
  final String? refreshToken;
  final String? token;
  final int? expiredAt;

  _Data({
    this.refreshToken,
    this.token,
    this.expiredAt,
  });

  factory _Data.fromJson(Map<String, dynamic> json) => _Data(
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
