import 'dart:convert';

import 'package:mealmate/features/recipe/data/models/recipe_step_model.dart';
import 'package:mealmate/features/recipe/data/models/show_recipe_response_model.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';

RecipeModel recipeModelFromJson(String str) =>
    RecipeModel.fromJson(json.decode(str));

String recipeModelToJson(RecipeModel data) => json.encode(data.toJson());

class RecipeModel {
  final int? id;
  final String? name;
  final int? numberCooked;
  final String? description;
  final int? rateCount;
  final int? rateAvg;
  final String? time;
  final String? url;
  final int? feeds;
  final String? hash;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? typeId;
  final int? userId;
  final int? categoryId;
  final Category? type;
  final UserModel? user;
  final Category? category;
  final List<IngredientModel>? ingredients;
  final List<RecipeStepModel>? steps;
  final _LikedRecipeModel? likedRecipe;

  RecipeModel({
    this.id,
    this.name,
    this.numberCooked,
    this.description,
    this.rateCount,
    this.rateAvg,
    this.time,
    this.url,
    this.feeds,
    this.hash,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.typeId,
    this.userId,
    this.categoryId,
    this.type,
    this.user,
    this.category,
    this.ingredients,
    this.steps,
    this.likedRecipe,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        numberCooked: json["number_cooked"],
        description: json["description"],
        rateCount: json["rate_count"],
        rateAvg: json["rate_avg"],
        time: json["time"],
        url: json["url"],
        feeds: json["feeds"],
        hash: json["hash"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        typeId: json["type_id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        type: json["type"] == null ? null : Category.fromJson(json["type"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        ingredients: json["ingredients"] == null
            ? []
            : List<IngredientModel>.from(
                json["ingredients"]!.map((x) => IngredientModel.fromJson(x))),
        steps: json["steps"] == null
            ? []
            : List<RecipeStepModel>.from(
                json["steps"]!.map((x) => RecipeStepModel.fromJson(x))),
        likedRecipe: json["likerecipe"] == null
            ? null
            : _LikedRecipeModel.fromJson(json["likerecipe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "number_cooked": numberCooked,
        "description": description,
        "rate_count": rateCount,
        "rate_avg": rateAvg,
        "time": time,
        "url": url,
        "feeds": feeds,
        "hash": hash,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "type_id": typeId,
        "user_id": userId,
        "category_id": categoryId,
        "type": type?.toJson(),
        "user": user?.toJson(),
        "category": category?.toJson(),
        "ingredients": ingredients == null
            ? []
            : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "likerecipe": likedRecipe?.toJson(),
      };
}

class _LikedRecipeModel {
  final int? id;
  final int? userId;
  final int? recipeId;

  _LikedRecipeModel({
    this.id,
    this.userId,
    this.recipeId,
  });

  _LikedRecipeModel copyWith({
    int? id,
    int? userId,
    int? recipeId,
  }) =>
      _LikedRecipeModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        recipeId: recipeId ?? this.recipeId,
      );

  factory _LikedRecipeModel.fromJson(Map<String, dynamic> json) =>
      _LikedRecipeModel(
        id: json["id"],
        userId: json["user_id"],
        recipeId: json["recipe_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "recipe_id": recipeId,
      };
}
