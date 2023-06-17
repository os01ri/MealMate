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
  final int? id;
  final String? name;
  final String? url;
  final String? hash;

  IngredientCategoryModel({
    this.id,
    this.name,
    this.url,
    this.hash,
  });

  IngredientCategoryModel copyWith({
    int? id,
    String? name,
    String? url,
    String? hash,
  }) =>
      IngredientCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        hash: hash ?? this.hash,
      );

  factory IngredientCategoryModel.fromJson(Map<String, dynamic> json) => IngredientCategoryModel(
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
