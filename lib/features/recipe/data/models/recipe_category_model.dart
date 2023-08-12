// To parse this JSON data, do
//
//     final recipeCategoryResponseModel = recipeCategoryResponseModelFromJson(jsonString);

import 'dart:convert';

RecipeCategoryResponseModel recipeCategoryResponseModelFromJson(String str) =>
    RecipeCategoryResponseModel.fromJson(json.decode(str));

String recipeCategoryResponseModelToJson(RecipeCategoryResponseModel data) =>
    json.encode(data.toJson());

class RecipeCategoryResponseModel {
  final String message;
  final List<RecipeCategoryModel> data;
  final bool success;

  RecipeCategoryResponseModel({
    required this.message,
    required this.data,
    required this.success,
  });

  factory RecipeCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      RecipeCategoryResponseModel(
        message: json["message"],
        data: List<RecipeCategoryModel>.from(
            json["data"].map((x) => RecipeCategoryModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class RecipeCategoryModel {
  final int id;
  final String name;
  final String url;
  final String hash;

  RecipeCategoryModel({
    required this.id,
    required this.name,
    required this.url,
    required this.hash,
  });

  factory RecipeCategoryModel.fromJson(Map<String, dynamic> json) =>
      RecipeCategoryModel(
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
