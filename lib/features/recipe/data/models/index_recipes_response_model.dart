import 'dart:convert';

import 'recipe_model.dart';

IndexRecipesResponseModel indexRecipesResponseModelFromJson(String str) =>
    IndexRecipesResponseModel.fromJson(json.decode(str));

String indexRecipesResponseModelToJson(IndexRecipesResponseModel data) => json.encode(data.toJson());

class IndexRecipesResponseModel {
  final String? message;
  final List<RecipeModel>? data;
  final bool? success;

  IndexRecipesResponseModel({
    this.message,
    this.data,
    this.success,
  });

  IndexRecipesResponseModel copyWith({
    String? message,
    List<RecipeModel>? data,
    bool? success,
  }) =>
      IndexRecipesResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory IndexRecipesResponseModel.fromJson(Map<String, dynamic> json) => IndexRecipesResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<RecipeModel>.from(json["data"]!.map((x) => RecipeModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}
