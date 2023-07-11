// To parse this JSON data, do
//
//     final recipeModel = recipeModelFromJson(jsonString);

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

class CategoryModel {
  final int? id;
  final String? name;
  final String? url;
  final String? hash;

  CategoryModel({
    this.id,
    this.name,
    this.url,
    this.hash,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        hash: json["hash"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "hash": hash,
      };
}

class RecipeIngredient {
  final int? id;
  final int? recipeId;
  final int? ingredientId;
  final int? quantity;
  final int? unitId;

  RecipeIngredient({
    this.id,
    this.recipeId,
    this.ingredientId,
    this.quantity,
    this.unitId,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) => RecipeIngredient(
        id: json["id"],
        recipeId: json["recipe_id"],
        ingredientId: json["ingredient_id"],
        quantity: json["quantity"],
        unitId: json["unit_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recipe_id": recipeId,
        "ingredient_id": ingredientId,
        "quantity": quantity,
        "unit_id": unitId,
      };
}

class Step {
  final int? id;
  final String? name;
  final int? rank;
  final String? description;

  Step({
    this.id,
    this.name,
    this.rank,
    this.description,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        id: json["id"],
        name: json["name"],
        rank: json["rank"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rank": rank,
        "description": description,
      };
}
