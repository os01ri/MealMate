import 'dart:convert';

import 'index_ingredients_response_model.dart';

IndexWishlistItemsResponseModel indexWishlistItemsResponseModelFromJson(String str) =>
    IndexWishlistItemsResponseModel.fromJson(json.decode(str));

String indexWishlistItemsResponseModelToJson(IndexWishlistItemsResponseModel data) => json.encode(data.toJson());

class IndexWishlistItemsResponseModel {
  final String? message;
  final List<WishlistItem>? items;
  final bool? success;

  IndexWishlistItemsResponseModel({
    this.message,
    this.items,
    this.success,
  });

  IndexWishlistItemsResponseModel copyWith({
    String? message,
    List<WishlistItem>? data,
    bool? success,
  }) =>
      IndexWishlistItemsResponseModel(
        message: message ?? this.message,
        items: data ?? items,
        success: success ?? this.success,
      );

  factory IndexWishlistItemsResponseModel.fromJson(Map<String, dynamic> json) => IndexWishlistItemsResponseModel(
        message: json["message"],
        items: json["data"] == null ? [] : List<WishlistItem>.from(json["data"]!.map((x) => WishlistItem.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "success": success,
      };
}

class WishlistItem {
  final String? id;
  final IngredientModel? ingredient;

  WishlistItem({
    this.id,
    this.ingredient,
  });

  WishlistItem copyWith({
    String? id,
    IngredientModel? ingredient,
  }) =>
      WishlistItem(
        id: id ?? this.id,
        ingredient: ingredient ?? this.ingredient,
      );

  factory WishlistItem.fromJson(Map<String, dynamic> json) => WishlistItem(
        id: json["id"],
        ingredient: json["ingredient"] == null ? null : IngredientModel.fromJson(json["ingredient"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ingredient": ingredient?.toJson(),
      };
}
