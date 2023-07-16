// To parse this JSON data, do
//
//     final imageUploadResponseModel = imageUploadResponseModelFromJson(jsonString);

import 'dart:convert';

ImageUploadResponseModel imageUploadResponseModelFromJson(String str) =>
    ImageUploadResponseModel.fromJson(json.decode(str));

String imageUploadResponseModelToJson(ImageUploadResponseModel data) => json.encode(data.toJson());

class ImageUploadResponseModel {
  final String? message;
  final List<ImageUploadModel>? data;
  final bool? success;

  ImageUploadResponseModel({
    this.message,
    this.data,
    this.success,
  });

  factory ImageUploadResponseModel.fromJson(Map<String, dynamic> json) => ImageUploadResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ImageUploadModel>.from(json["data"]!.map((x) => ImageUploadModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class ImageUploadModel {
  final String? url;

  ImageUploadModel({
    this.url,
  });

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) => ImageUploadModel(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
