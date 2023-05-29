import 'dart:convert';

IndexIngredientsResponseModel indexIngredientsResponseModelFromJson(String str) =>
    IndexIngredientsResponseModel.fromJson(json.decode(str));

String indexIngredientsResponseModelToJson(IndexIngredientsResponseModel data) => json.encode(data.toJson());

class IndexIngredientsResponseModel {
  final bool? success;
  final String? message;
  final List<IngredientModel>? data;

  IndexIngredientsResponseModel({
    this.success,
    this.message,
    this.data,
  });

  IndexIngredientsResponseModel copyWith({
    bool? success,
    String? message,
    List<IngredientModel>? data,
  }) =>
      IndexIngredientsResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory IndexIngredientsResponseModel.fromJson(Map<String, dynamic> json) => IndexIngredientsResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? [] : List<IngredientModel>.from(json["data"]!.map((x) => IngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class IngredientModel {
  final String? id;
  final String? name;
  final int? price;
  final int? priceBy;
  final List<NutritionalValue>? nutritionalValues;
final String? url;
  IngredientModel({
    this.id,
    this.name,
    this.price,
    this.priceBy,
      this.nutritionalValues,
      this.url
  });

  IngredientModel copyWith({
    String? id,
    String? name,
    String? url,
    int? price,
    int? priceBy,
    List<NutritionalValue>? nutritionalValues,
  }) =>
      IngredientModel(
        id: id ?? this.id,
        url: url ?? this.url,
        name: name ?? this.name,
        price: price ?? this.price,
        priceBy: priceBy ?? this.priceBy,
        nutritionalValues: nutritionalValues ?? this.nutritionalValues,
      );

  factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        priceBy: json["price_by"],
        url: json["url"],
        nutritionalValues: json["nutritionals"] == null
            ? []
            : List<NutritionalValue>.from(json["nutritionals"]!.map((x) => NutritionalValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "price_by": priceBy,
        "url": url,
        "nutritionals": nutritionalValues == null ? [] : List<dynamic>.from(nutritionalValues!.map((x) => x.toJson())),
      };
}

class NutritionalValue {
  final String? id;
  final String? name;
  final IngredientNutritionals? ingredientNutritionals;

  NutritionalValue({
    this.id,
    this.name,
    this.ingredientNutritionals,
  });

  NutritionalValue copyWith({
    String? id,
    String? name,
    IngredientNutritionals? ingredientNutritionals,
  }) =>
      NutritionalValue(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredientNutritionals: ingredientNutritionals ?? this.ingredientNutritionals,
      );

  factory NutritionalValue.fromJson(Map<String, dynamic> json) => NutritionalValue(
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

  IngredientNutritionals copyWith({
    int? value,
  }) =>
      IngredientNutritionals(
        value: value ?? this.value,
      );

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) => IngredientNutritionals(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
