import 'dart:convert';

class IngredientModelResponse {
  final List<IngredientModel>? data;

  IngredientModelResponse({
    this.data,
  });

  IngredientModelResponse copyWith({
    List<IngredientModel>? data,
  }) =>
      IngredientModelResponse(
        data: data ?? this.data,
      );

  factory IngredientModelResponse.fromRawJson(String str) => IngredientModelResponse.fromJson(
        json.decode('{"data":$str}'),
      );

  String toRawJson() => json.encode(toJson());

  factory IngredientModelResponse.fromJson(Map<String, dynamic> json) => IngredientModelResponse(
        data: json["data"] == null
            ? []
            : List<IngredientModel>.from(json["data"]!.map((x) => IngredientModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class IngredientModel {
  final String? id;
  final String? name;
  final List<Nutritional>? nutritionals;

  IngredientModel({
    this.id,
    this.name,
    this.nutritionals,
  });

  IngredientModel copyWith({
    String? id,
    String? name,
    List<Nutritional>? nutritionals,
  }) =>
      IngredientModel(
        id: id ?? this.id,
        name: name ?? this.name,
        nutritionals: nutritionals ?? this.nutritionals,
      );

  factory IngredientModel.fromRawJson(String str) => IngredientModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IngredientModel.fromJson(Map<String, dynamic> json) => IngredientModel(
        id: json["id"],
        name: json["name"],
        nutritionals: json["nutritionals"] == null
            ? []
            : List<Nutritional>.from(json["nutritionals"]!.map((x) => Nutritional.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nutritionals": nutritionals == null ? [] : List<dynamic>.from(nutritionals!.map((x) => x.toJson())),
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

  Nutritional copyWith({
    String? id,
    String? name,
    IngredientNutritionals? ingredientNutritionals,
  }) =>
      Nutritional(
        id: id ?? this.id,
        name: name ?? this.name,
        ingredientNutritionals: ingredientNutritionals ?? this.ingredientNutritionals,
      );

  factory Nutritional.fromRawJson(String str) => Nutritional.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  IngredientNutritionals copyWith({
    int? value,
  }) =>
      IngredientNutritionals(
        value: value ?? this.value,
      );

  factory IngredientNutritionals.fromRawJson(String str) => IngredientNutritionals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory IngredientNutritionals.fromJson(Map<String, dynamic> json) => IngredientNutritionals(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}
