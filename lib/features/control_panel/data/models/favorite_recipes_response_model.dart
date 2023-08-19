import 'dart:convert';

import '../../../recipe/data/models/recipe_model.dart';

FavoriteRecipesResponseModel favoriteRecipesResponseModelFromJson(String str) =>
    FavoriteRecipesResponseModel.fromJson(json.decode(str));

String favoriteRecipesResponseModelToJson(FavoriteRecipesResponseModel data) => json.encode(data.toJson());

class FavoriteRecipesResponseModel {
  final String? message;
  final Data? data;
  final bool? success;

  FavoriteRecipesResponseModel({
    this.message,
    this.data,
    this.success,
  });

  FavoriteRecipesResponseModel copyWith({
    String? message,
    Data? data,
    bool? success,
  }) =>
      FavoriteRecipesResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory FavoriteRecipesResponseModel.fromJson(Map<String, dynamic> json) => FavoriteRecipesResponseModel(
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
  final List<RecipeModel>? likedRecipes;

  Data({
    this.likedRecipes,
  });

  Data copyWith({
    List<RecipeModel>? likedRecipes,
  }) =>
      Data(
        likedRecipes: likedRecipes ?? this.likedRecipes,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        likedRecipes: json["likerecipes"] == null
            ? []
            : List<RecipeModel>.from(json["likerecipes"]!.map((x) => RecipeModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "likerecipes": likedRecipes == null ? [] : List<dynamic>.from(likedRecipes!.map((x) => x.toJson())),
      };
}
