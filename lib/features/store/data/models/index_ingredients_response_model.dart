import 'dart:convert';

import '../../../recipe/data/models/show_recipe_response_model.dart';
import 'index_ingredients_categories_response_model.dart';

IndexIngredientsResponseModel indexIngredientsResponseModelFromJson(String str) =>
    IndexIngredientsResponseModel.fromJson(json.decode(str));

String indexIngredientsResponseModelToJson(IndexIngredientsResponseModel data) => json.encode(data.toJson());

class IndexIngredientsResponseModel {
  final String? message;
  final List<IngredientModel>? data;
  final bool? success;

  IndexIngredientsResponseModel({
    this.message,
    this.data,
    this.success,
  });

  IndexIngredientsResponseModel copyWith({
    String? message,
    List<IngredientModel>? data,
    bool? success,
  }) =>
      IndexIngredientsResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory IndexIngredientsResponseModel.fromJson(Map<String, dynamic> json) => IndexIngredientsResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<IngredientModel>.from(json["data"]!.map((x) => IngredientModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class IngredientModel {
  final int? id;
  final String? name;
  final int? price;
  final String? url;
  final String? hash;
  final int? priceBy;
  final RecipeIngredient? recipeIngredient;

  final List<Nutritional>? nutritionals;
  final UnitModel? unit;
  final IngredientCategoryModel? category;

  const IngredientModel({
    this.recipeIngredient,
    this.id,
    this.name,
    this.price,
    this.url,
    this.hash,
    this.priceBy,
    this.nutritionals,
    this.unit,
    this.category,
  });

  IngredientModel copyWith({
    int? id,
    String? name,
    int? price,
    String? url,
    String? hash,
    int? priceBy,
    List<Nutritional>? nutritionals,
    UnitModel? unit,
    IngredientCategoryModel? category,
  }) =>
      IngredientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        url: url ?? this.url,
        hash: hash ?? this.hash,
        priceBy: priceBy ?? this.priceBy,
        nutritionals: nutritionals ?? this.nutritionals,
        unit: unit ?? this.unit,
        category: category ?? this.category,
      );

  factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        url: json["url"],
        hash: json["hash"],
        recipeIngredient:
            json["recipe_ingredient"] == null ? null : RecipeIngredient.fromJson(json["recipe_ingredient"]),

        priceBy: json["price_by"],
        nutritionals: json["nutritionals"] == null
            ? []
            : List<Nutritional>.from(json["nutritionals"]!.map((x) => Nutritional.fromJson(x))),
        unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
        category: json["category1"] == null ? null : IngredientCategoryModel.fromJson(json["category1"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url": url,
        "hash": hash,
        "price_by": priceBy,
        "nutritionals": nutritionals == null ? [] : List<dynamic>.from(nutritionals!.map((x) => x.toJson())),
        "unit": unit?.toJson(),
        "category1": category?.toJson(),
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

  Nutritional copyWith({
    int? id,
    String? name,
    IngredientNutritionals? ingredientNutritionals,
  }) =>
      Nutritional(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredientNutritionals: ingredientNutritionals ?? this.ingredientNutritionals,
      );

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
  final double? percent;

  IngredientNutritionals({
    this.percent,
    this.value,
  });

  IngredientNutritionals copyWith({
    int? value,
    double? percent,
  }) =>
      IngredientNutritionals(
        value: value ?? this.value,
      );

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) => IngredientNutritionals(
        value: json["value"],
        percent: json["precent"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "precent": percent,
      };
}

class UnitModel {
  final int? id;
  final String? name;
  final String? code;

  UnitModel({
    this.id,
    this.name,
    this.code,
  });

  UnitModel copyWith({
    int? id,
    String? name,
    String? code,
  }) =>
      UnitModel(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
      );

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
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
