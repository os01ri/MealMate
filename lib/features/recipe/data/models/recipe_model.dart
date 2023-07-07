class RecipeModel {
  final String? id;
  final String? name;
  final String? description;
  final String? time;
  final String? url;
  final bool? status;
  final String? typeId;
  final String? categoryId;
  final CategoryModel? type;
  final CategoryModel? category;

  const RecipeModel({
    this.id,
    this.name,
    this.description,
    this.time,
    this.url,
    this.status,
    this.typeId,
    this.categoryId,
    this.type,
    this.category,
  });

  RecipeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? time,
    String? url,
    bool? status,
    String? typeId,
    String? categoryId,
    CategoryModel? type,
    CategoryModel? category,
  }) =>
      RecipeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        time: time ?? this.time,
        url: url ?? this.url,
        status: status ?? this.status,
        typeId: typeId ?? this.typeId,
        categoryId: categoryId ?? this.categoryId,
        type: type ?? this.type,
        category: category ?? this.category,
      );

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        time: json["time"],
        url: json["url"],
        status: json["status"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        type: json["type"] == null ? null : CategoryModel.fromJson(json["type"]),
        category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "time": time,
        "url": url,
        "status": status,
        "type_id": typeId,
        "category_id": categoryId,
        "type": type?.toJson(),
        "category": category?.toJson(),
      };
}

class CategoryModel {
  final String? id;
  final String? name;
  final String? url;

  const CategoryModel({
    this.id,
    this.name,
    this.url,
  });

  CategoryModel copyWith({
    String? id,
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
