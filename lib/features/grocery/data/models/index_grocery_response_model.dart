// To parse this JSON data, do
//
//     final indexGroceryResponseModel = indexGroceryResponseModelFromJson(jsonString);

import 'dart:convert';

IndexGroceryResponseModel indexGroceryResponseModelFromJson(String str) =>
    IndexGroceryResponseModel.fromJson(json.decode(str));

String indexGroceryResponseModelToJson(IndexGroceryResponseModel data) =>
    json.encode(data.toJson());

class IndexGroceryResponseModel {
  final String? message;
  final List<IndexGroceryDataModel>? data;
  final bool? success;

  IndexGroceryResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory IndexGroceryResponseModel.fromJson(Map<String, dynamic> json) =>
      IndexGroceryResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<IndexGroceryDataModel>.from(
                json["data"]!.map((x) => IndexGroceryDataModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class IndexGroceryDataModel {
  final int? id;
  final int? quantity;
  final IngredientGroceryModel? ingredient;
  final Unit? unit;

  IndexGroceryDataModel({
    this.id,
    this.quantity,
    this.ingredient,
    this.unit,
  });

  factory IndexGroceryDataModel.fromJson(Map<String, dynamic> json) =>
      IndexGroceryDataModel(
        id: json["id"],
        quantity: json["quantity"],
        ingredient: json["ingredient"] == null
            ? null
            : IngredientGroceryModel.fromJson(json["ingredient"]),
        unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "ingredient": ingredient?.toJson(),
        "unit": unit?.toJson(),
      };
}

class IngredientGroceryModel {
  final int? id;
  final String? name;
  final int? price;
  final String? url;
  final String? hash;
  final int? priceBy;

  IngredientGroceryModel({
    this.id,
    this.name,
    this.price,
    this.url,
    this.hash,
    this.priceBy,
  });

  factory IngredientGroceryModel.fromJson(Map<String, dynamic> json) =>
      IngredientGroceryModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        url: json["url"],
        hash: json["hash"],
        priceBy: json["price_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url": url,
        "hash": hash,
        "price_by": priceBy,
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
