import 'dart:convert';

RecipeCategoryResponseModel recipeCategoryResponseModelFromJson(String str) =>
    RecipeCategoryResponseModel.fromJson(json.decode(str));

String recipeCategoryResponseModelToJson(RecipeCategoryResponseModel data) => json.encode(data.toJson());

class RecipeCategoryResponseModel {
  final String? message;
  final List<RecipeCategoryModel>? data;
  final bool? success;

  RecipeCategoryResponseModel({
    this.message,
    this.data,
    this.success,
  });

  RecipeCategoryResponseModel copyWith({
    String? message,
    List<RecipeCategoryModel>? data,
    bool? success,
  }) =>
      RecipeCategoryResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory RecipeCategoryResponseModel.fromJson(Map<String, dynamic> json) => RecipeCategoryResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<RecipeCategoryModel>.from(json["data"]!.map((x) => RecipeCategoryModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class RecipeCategoryModel {
  final int? id;
  final String? name;
  final String? url;
  final String? hash;

  const RecipeCategoryModel({
    this.id,
    this.name,
    this.url,
    this.hash,
  });

  RecipeCategoryModel copyWith({
    int? id,
    String? name,
    String? url,
    String? hash,
  }) =>
      RecipeCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        hash: hash ?? this.hash,
      );

  factory RecipeCategoryModel.fromJson(Map<String, dynamic> json) => RecipeCategoryModel(
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
