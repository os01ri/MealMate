import 'dart:convert';

import 'package:mealmate/features/recipe/domain/entities/recipe.dart';

class RecipeModel extends Recipe {
  RecipeModel({
    super.id,
    super.name,
    super.description,
  });

  RecipeModel copyWith({
    int? id,
    String? name,
    String? description,
  }) =>
      RecipeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory RecipeModel.fromRawJson(String str) => RecipeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };

  @override
  String toString() => 'RecipeModel(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(covariant RecipeModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ description.hashCode;
}
