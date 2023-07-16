class RecipeStepModel {
  final int? id;
  final String? name;
  final int? rank;
  final String? description;

  RecipeStepModel({
    this.id,
    this.name,
    this.rank,
    this.description,
  });

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) => RecipeStepModel(
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
