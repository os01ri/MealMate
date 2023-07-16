import 'dart:convert';

import 'package:mealmate/features/recipe/data/models/recipe_model.dart';

ShowRecipeResponseModel showRecipeModelFromJson(String str) => ShowRecipeResponseModel.fromJson(json.decode(str));

String showRecipeModelToJson(ShowRecipeResponseModel data) => json.encode(data.toJson());

class ShowRecipeResponseModel {
  final String? message;
  final RecipeModel? data;
  final bool? success;

  ShowRecipeResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory ShowRecipeResponseModel.fromJson(Map<String, dynamic> json) => ShowRecipeResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : RecipeModel.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}