import 'dart:convert';

RestrictionsResponseModel restrictionsResponseModelFromJson(String str) =>
    RestrictionsResponseModel.fromJson(json.decode(str));

String restrictionsResponseModelToJson(RestrictionsResponseModel data) => json.encode(data.toJson());

class RestrictionsResponseModel {
  final String? message;
  final List<RestrictionModel>? data;
  final bool? success;

  RestrictionsResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory RestrictionsResponseModel.fromJson(Map<String, dynamic> json) => RestrictionsResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<RestrictionModel>.from(json["data"]!.map((x) => RestrictionModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class RestrictionModel {
  final int? id;
  final String? name;
  final int? price;
  final String? url;
  final String? hash;
  final int? priceBy;

  const RestrictionModel({
    this.id,
    this.name,
    this.price,
    this.url,
    this.hash,
    this.priceBy,
  });

  factory RestrictionModel.fromJson(Map<String, dynamic> json) => RestrictionModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        url: json["url"],
        hash: json["hash"],
        priceBy: json["price_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "url": url,
        "hash": hash,
        "price_by": priceBy,
      };
}
