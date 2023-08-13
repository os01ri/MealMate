class RecipeStepModel {
  final int? id;
  final String? name;
  final int? rank;
  final String? description;
  final int? time;

  RecipeStepModel({this.id, this.name, this.rank, this.description, this.time});

  factory RecipeStepModel.fromJson(Map<String, dynamic> json) =>
      RecipeStepModel(
          id: json["id"],
          name: json["name"],
          rank: json["rank"],
          description: json["description"],
          time: json['time']);

  Map<String, dynamic> toJson() =>
      {"name": name, "rank": rank, "description": description, "time": time};
}
