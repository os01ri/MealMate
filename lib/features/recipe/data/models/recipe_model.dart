import '../../../store/data/models/index_ingredients_response_model.dart';
import 'recipe_category_model.dart';
import 'recipe_step_model.dart';

class RecipeModel {
  final int? id;
  final String? name;
  final String? description;
  final String? time;
  final String? url;
  final String? hash;
  final bool? status;
  final dynamic userId;
  final RecipeCategoryModel? type;
  final RecipeCategoryModel? category;
  final List<IngredientModel>? ingredients;
  final List<RecipeStepModel>? steps;

  RecipeModel({
    this.id,
    this.name,
    this.description,
    this.time,
    this.url,
    this.hash,
    this.status,
    this.userId,
    this.type,
    this.category,
    this.ingredients,
    this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        time: json["time"],
        url: json["url"],
        hash: json["hash"],
        status: json["status"],
        userId: json["user_id"],
        type: json["type"] == null ? null : RecipeCategoryModel.fromJson(json["type"]),
        category: json["category"] == null ? null : RecipeCategoryModel.fromJson(json["category"]),
        ingredients: json["ingredients"] == null
            ? []
            : List<IngredientModel>.from(json["ingredients"]!.map((x) => IngredientModel.fromJson(x))),
        steps: json["steps"] == null
            ? []
            : List<RecipeStepModel>.from(json["steps"]!.map((x) => RecipeStepModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "time": time,
        "url": url,
        "hash": hash,
        "status": status,
        "user_id": userId,
        "type": type?.toJson(),
        "category": category?.toJson(),
        "ingredients": ingredients == null ? [] : List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x.toJson())),
      };
}
