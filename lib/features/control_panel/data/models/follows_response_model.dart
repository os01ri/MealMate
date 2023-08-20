import 'dart:convert';

import '../../../auth/data/models/user_model.dart';

FollowsResponseModel followsResponseModelFromJson(String str) => FollowsResponseModel.fromJson(json.decode(str));

String followsResponseModelToJson(FollowsResponseModel data) => json.encode(data.toJson());

class FollowsResponseModel {
  final String? message;
  final List<UserModel>? data;
  final bool? success;

  FollowsResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory FollowsResponseModel.fromJson(Map<String, dynamic> json) => FollowsResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<UserModel>.from(json["data"]!.map((x) => UserModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}
