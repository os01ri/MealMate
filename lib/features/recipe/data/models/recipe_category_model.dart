class RecipeCategoryModel {
  final int? id;
  final String? name;
  final String? url;

  const RecipeCategoryModel({
    this.id,
    this.name,
    this.url,
  });

  RecipeCategoryModel copyWith({
    int? id,
    String? name,
    String? url,
  }) =>
      RecipeCategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory RecipeCategoryModel.fromJson(Map<String, dynamic> json) => RecipeCategoryModel(
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
