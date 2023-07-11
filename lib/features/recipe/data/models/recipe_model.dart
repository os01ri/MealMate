import '../../../store/data/models/index_ingredients_response_model.dart';

class RecipeModel {
  final int? id;
  final String? name;
  final String? description;
  final String? time;
  final String? url;
  final String? hash;
  final bool? status;
  final dynamic userId;
  final CategoryModel? type;
  final CategoryModel? category;
  final List<IngredientModel>? ingredients;
  final List<Step>? steps;

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
        type: json["type"] == null ? null : CategoryModel.fromJson(json["type"]),
        category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
        ingredients: json["ingredients"] == null
            ? []
            : List<IngredientModel>.from(json["ingredients"]!.map((x) => IngredientModel.fromJson(x))),
        steps: json["steps"] == null ? [] : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
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


class CategoryModel {
  final int? id;
  final String? name;
  final String? url;

  const CategoryModel({
    this.id,
    this.name,
    this.url,
  });

  CategoryModel copyWith({
    int? id,
    String? name,
    String? url,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
      };
}

class Step {
  final int? id;
  final String? name;
  final int? rank;
  final String? description;

  Step({
    this.id,
    this.name,
    this.rank,
    this.description,
  });

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        id: json["id"],
        name: json["name"],
        rank: json["rank"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "rank": rank,
        "description": description,
      };
}
