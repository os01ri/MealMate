// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:mealmate/features/auth/data/models/user_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final String? message;
  final UserModel? data;
  final bool? success;

  LoginResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}



