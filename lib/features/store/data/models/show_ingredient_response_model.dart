
import 'dart:convert';

import 'index_ingredients_response_model.dart';

ShowIngredientResponseModel showIngredientResponseModelFromJson(String str) =>
    ShowIngredientResponseModel.fromJson(json.decode(str));

String showIngredientResponseModelToJson(ShowIngredientResponseModel data) => json.encode(data.toJson());

class ShowIngredientResponseModel {
  final String? message;
  final IngredientModel? data;
  final bool? success;

  ShowIngredientResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory ShowIngredientResponseModel.fromJson(Map<String, dynamic> json) =>
      ShowIngredientResponseModel(
        message: json["message"],
        data: json["data"] == null ? null : IngredientModel.fromJson(json["data"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "success": success,
      };
}

class Category1 {
  final String? id;
  final String? name;
  final String? url;

  Category1({
    this.id,
    this.name,
    this.url,
  });

  factory Category1.fromJson(Map<String, dynamic> json) => Category1(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class Nutritional {
  final String? id;
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

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) =>
      IngredientNutritionals(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
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
