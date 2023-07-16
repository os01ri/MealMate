// To parse this JSON data, do
//
//     final showRecipeResponseModel = showRecipeResponseModelFromJson(jsonString);

import 'dart:convert';

import 'recipe_model.dart';

ShowRecipeResponseModel showRecipeResponseModelFromJson(String str) =>
    ShowRecipeResponseModel.fromJson(json.decode(str));

String showRecipeResponseModelToJson(ShowRecipeResponseModel data) => json.encode(data.toJson());

class ShowRecipeResponseModel {
  final String? message;
  final Data? data;
  final bool? success;

  ShowRecipeResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory ShowRecipeResponseModel.fromJson(Map<String, dynamic> json) => ShowRecipeResponseModel(
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
  final RecipeModel? recipes;
  final List<Nutritional>? nutritionals;
  final int? sum;

  Data({
    this.recipes,
    this.nutritionals,
    this.sum,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        recipes: json["recipes"] == null ? null : RecipeModel.fromJson(json["recipes"]),
        nutritionals: json["nutritionals"] == null
            ? []
            : List<Nutritional>.from(json["nutritionals"]!.map((x) => Nutritional.fromJson(x))),
        sum: json["sum"],
      );

  Map<String, dynamic> toJson() => {
        "recipes": recipes?.toJson(),
        "nutritionals": nutritionals == null ? [] : List<dynamic>.from(nutritionals!.map((x) => x.toJson())),
        "sum": sum,
      };
}

class Nutritional {
  final int? id;
  final String? name;
  final IngredientNutritionals? ingredientNutritionals;

  Nutritional({
    this.id,
    this.name,
    this.ingredientNutritionals,
  });

  factory Nutritional.fromJson(Map<String, dynamic> json) => Nutritional(
        id: json["id"],
        name: json["name"],
        ingredientNutritionals: json["ingredient_nutritionals"] == null
            ? null
            : IngredientNutritionals.fromJson(json["ingredient_nutritionals"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredient_nutritionals": ingredientNutritionals?.toJson(),
      };
}

class IngredientNutritionals {
  final int? value;

  IngredientNutritionals({
    this.value,
  });

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) => IngredientNutritionals(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Recipes {
  final int? id;
  final String? name;
  final String? description;
  final String? time;
  final String? url;
  final int? feeds;
  final String? hash;
  final bool? status;
  final dynamic userId;
  final Category? type;
  final Category? category;
  final List<Ingredient>? ingredients;
  final List<Step>? steps;

  Recipes({
    this.id,
    this.name,
    this.description,
    this.time,
    this.url,
    this.feeds,
    this.hash,
    this.status,
    this.userId,
    this.type,
    this.category,
    this.ingredients,
    this.steps,
  });

  factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        time: json["time"],
        url: json["url"],
        feeds: json["feeds"],
        hash: json["hash"],
        status: json["status"],
        userId: json["user_id"],
        type: json["type"] == null ? null : Category.fromJson(json["type"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        ingredients: json["ingredients"] == null
            ? []
            : List<Ingredient>.from(json["ingredients"]!.map((x) => Ingredient.fromJson(x))),
        steps: json["steps"] == null ? [] : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "time": time,
        "url": url,
        "feeds": feeds,
        "hash": hash,
        "status": status,
        "user_id": userId,
        "type": type?.toJson(),
        "category": category?.toJson(),
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}

class Category {
  final int? id;
  final String? name;
  final String? url;
  final String? hash;

  Category({
    this.id,
    this.name,
    this.url,
    this.hash,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class Ingredient {
  final int? id;
  final String? name;
  final int? price;
  final String? url;
  final String? hash;
  final int? priceBy;
  final RecipeIngredient? recipeIngredient;
  final Unit? unit;

  Ingredient({
    this.id,
    this.name,
    this.price,
    this.url,
    this.hash,
    this.priceBy,
    this.recipeIngredient,
    this.unit,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        url: json["url"],
        hash: json["hash"],
        priceBy: json["price_by"],
        recipeIngredient:
            json["recipe_ingredient"] == null ? null : RecipeIngredient.fromJson(json["recipe_ingredient"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url": url,
        "hash": hash,
        "price_by": priceBy,
        "recipe_ingredient": recipeIngredient?.toJson(),
        "unit": unit?.toJson(),
      };
}

class RecipeIngredient {
  final int? quantity;

  RecipeIngredient({
    this.quantity,
  });

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) => RecipeIngredient(
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
      };
}

class Unit {
  final int? id;
  final String? name;
  final String? code;

  Unit({
    this.id,
    this.name,
    this.code,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
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
