import 'dart:convert';

IndexIngredientCategoriesResponseModel indexIngredientCategoriesResponseModelFromJson(String str) =>
    IndexIngredientCategoriesResponseModel.fromJson(json.decode(str));

String indexIngredientCategoriesResponseModelToJson(IndexIngredientCategoriesResponseModel data) =>
    json.encode(data.toJson());

class IndexIngredientCategoriesResponseModel {
  final bool? success;
  final String? message;
  final List<IngredientCategoryModel>? data;

  IndexIngredientCategoriesResponseModel({
    this.success,
    this.message,
    this.data,
  });

  IndexIngredientCategoriesResponseModel copyWith({
    bool? success,
    String? message,
    List<IngredientCategoryModel>? data,
  }) =>
      IndexIngredientCategoriesResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory IndexIngredientCategoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      IndexIngredientCategoriesResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<IngredientCategoryModel>.from(json["data"]!.map((x) => IngredientCategoryModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class IngredientCategoryModel {
  final String? id;
  final String? name;
  final String? url;
  final List<dynamic>? ingredients;

  const IngredientCategoryModel({
    this.id,
    this.name,
    this.url,
    this.ingredients,
  });

  IngredientCategoryModel copyWith({
    String? id,
    String? name,
    String? url,
    List<dynamic>? ingredients,
  }) =>
      IngredientCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        ingredients: ingredients ?? this.ingredients,
      );

  factory IngredientCategoryModel.fromJson(Map<String, dynamic> json) => IngredientCategoryModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        ingredients: json["ingredients"] == null ? [] : List<dynamic>.from(json["ingredients"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x)),
      };
}
