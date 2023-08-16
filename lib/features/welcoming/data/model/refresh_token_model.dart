// To parse this JSON data, do
//
//     final refreshTokenResponseModel = refreshTokenResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:mealmate/features/auth/data/models/user_model.dart';

RefreshTokenResponseModel refreshTokenResponseModelFromJson(String str) =>
    RefreshTokenResponseModel.fromJson(json.decode(str));

String refreshTokenResponseModelToJson(RefreshTokenResponseModel data) =>
    json.encode(data.toJson());

class RefreshTokenResponseModel {
  final String? message;
  final TokenInfo? data;
  final bool? success;

  RefreshTokenResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory RefreshTokenResponseModel.fromJson(Map<String, dynamic> json) =>
      RefreshTokenResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : TokenInfo.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}
