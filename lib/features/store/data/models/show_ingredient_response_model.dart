import 'dart:convert';

import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

ShowIngredientResponseModel showIngredientResponseModelFromJson(String str) =>
    ShowIngredientResponseModel.fromJson(json.decode(str));

String showIngredientResponseModelToJson(ShowIngredientResponseModel data) => json.encode(data.toJson());

class ShowIngredientResponseModel {
  final bool? success;
  final String? message;
  final IngredientModel? data;

  ShowIngredientResponseModel({
    this.success,
    this.message,
    this.data,
  });

  ShowIngredientResponseModel copyWith({
    bool? success,
    String? message,
    IngredientModel? data,
  }) =>
      ShowIngredientResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ShowIngredientResponseModel.fromJson(Map<String, dynamic> json) => ShowIngredientResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : IngredientModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}
