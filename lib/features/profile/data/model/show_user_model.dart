// To parse this JSON data, do
//
//     final showUserModelResponse = showUserModelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:mealmate/features/recipe/data/models/recipe_model.dart';

ShowUserModelResponse showUserModelResponseFromJson(String str) =>
    ShowUserModelResponse.fromJson(json.decode(str));

String showUserModelResponseToJson(ShowUserModelResponse data) =>
    json.encode(data.toJson());

class ShowUserModelResponse {
  final String? message;
  final ProfileModel? user;
  final bool? success;

  ShowUserModelResponse({
    this.message,
    this.user,
    this.success,
  });

  factory ShowUserModelResponse.fromJson(Map<String, dynamic> json) =>
      ShowUserModelResponse(
        message: json["message"],
        user: json["data"] == null ? null : ProfileModel.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": user?.toJson(),
        "success": success,
      };
}

class ProfileModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? logo;
  final String? city;
  final String? hash;
  final bool? status;
  final List<RecipeModel>? recipes;
  final List<dynamic>? followby;
  final List<dynamic>? follower;
  final bool? isFollow;

  ProfileModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.logo,
    this.city,
    this.hash,
    this.status,
    this.recipes,
    this.followby,
    this.follower,
    this.isFollow,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        logo: json["logo"],
        city: json["city"],
        hash: json["hash"],
        status: json["status"],
        recipes: json["recipes"] == null
            ? []
            : List<RecipeModel>.from(
                json["recipes"]!.map((x) => RecipeModel.fromJson(x))),
        followby: json["followby"] == null
            ? []
            : List<dynamic>.from(json["followby"]!.map((x) => x)),
        follower: json["follower"] == null
            ? []
            : List<dynamic>.from(json["follower"]!.map((x) => x)),
        isFollow: json["isFollow"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "logo": logo,
        "city": city,
        "hash": hash,
        "status": status,
        "recipes":
            recipes == null ? [] : List<dynamic>.from(recipes!.map((x) => x)),
        "followby":
            followby == null ? [] : List<dynamic>.from(followby!.map((x) => x)),
        "follower":
            follower == null ? [] : List<dynamic>.from(follower!.map((x) => x)),
        "isFollow": isFollow,
      };
}
