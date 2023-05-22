// import 'dart:convert';

// import 'package:mealmate/features/store/domain/entities/ingredient.dart';

// class IngredientModel extends Ingredient {
//   IngredientModel({
//     final String? name,
//     final double? price,
//     final String? imageUrl,
//   }) : super(
//           name: name,
//           price: price,
//           imageUrl: imageUrl,
//         );

//   IngredientModel copyWith({
//     String? name,
//     double? price,
//     String? imageUrl,
//   }) {
//     return IngredientModel(
//       name: name ?? this.name,
//       price: price ?? this.price,
//       imageUrl: imageUrl ?? this.imageUrl,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'price': price,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory IngredientModel.fromMap(Map<String, dynamic> map) {
//     return IngredientModel(
//       name: map['name'] != null ? map['name'] as String : null,
//       price: map['price'] != null ? map['price'] as double : null,
//       imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory IngredientModel.fromJson(String source) =>
//       IngredientModel.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'IngredientModel(name: $name, price: $price, imageUrl: $imageUrl)';

//   @override
//   bool operator ==(covariant IngredientModel other) {
//     if (identical(this, other)) return true;

//     return other.name == name && other.price == price && other.imageUrl == imageUrl;
//   }

//   @override
//   int get hashCode => name.hashCode ^ price.hashCode ^ imageUrl.hashCode;
// }

// To parse this JSON data, do
//
//     final ingredientModel = ingredientModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final ingredientModelResponse = ingredientModelResponseFromJson(jsonString);

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
