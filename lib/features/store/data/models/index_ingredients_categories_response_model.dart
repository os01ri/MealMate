// To parse this JSON data, do
//
//     final indexIngredientCategoriesResponseModel = indexIngredientCategoriesResponseModelFromJson(jsonString);

import 'dart:convert';

import 'index_ingredients_response_model.dart';

IndexIngredientCategoriesResponseModel indexIngredientCategoriesResponseModelFromJson(String str) =>
    IndexIngredientCategoriesResponseModel.fromJson(json.decode(str));

String indexIngredientCategoriesResponseModelToJson(IndexIngredientCategoriesResponseModel data) =>
    json.encode(data.toJson());

class IndexIngredientCategoriesResponseModel {
  final String? message;
  final Data? data;
  final bool? success;

  IndexIngredientCategoriesResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory IndexIngredientCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      IndexIngredientCategoriesResponseModel(
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
  final List<IngredientCategoryModel>? categories;
  final int? count;

  Data({
    this.categories,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null
            ? []
            : List<IngredientCategoryModel>.from(json["categories"]!.map((x) => IngredientCategoryModel.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "count": count,
      };
}

class IngredientCategoryModel {
  final int? id;
  final String? name;
  final String? url;
  final String? hash;
  final List<IngredientModel>? ingredients;

  IngredientCategoryModel({
    this.id,
    this.name,
    this.url,
    this.hash,
    this.ingredients,
  });

  factory IngredientCategoryModel.fromJson(Map<String, dynamic> json) => IngredientCategoryModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        hash: json["hash"],
        ingredients: json["ingredients"] == null
            ? []
            : List<IngredientModel>.from(json["ingredients"]!.map((x) => IngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "hash": hash,
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
      };
}
