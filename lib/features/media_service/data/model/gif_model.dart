import 'dart:convert';

GifUploadModelResponse gifUploadModelResponseFromJson(String str) =>
    GifUploadModelResponse.fromJson(json.decode(str));

String gifUploadModelResponseToJson(GifUploadModelResponse data) =>
    json.encode(data.toJson());

class GifUploadModelResponse {
  GifUploadModelResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  GifUploadDataModel? data;

  GifUploadModelResponse copyWith({
    bool? success,
    String? message,
    GifUploadDataModel? data,
  }) =>
      GifUploadModelResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GifUploadModelResponse.fromJson(Map<String, dynamic> json) =>
      GifUploadModelResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : GifUploadDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class GifUploadDataModel {
  GifUploadDataModel({
    this.gifUrl,
  });

  String? gifUrl;

  GifUploadDataModel copyWith({
    String? gifUrl,
  }) =>
      GifUploadDataModel(
        gifUrl: gifUrl ?? this.gifUrl,
      );

  factory GifUploadDataModel.fromJson(Map<String, dynamic> json) =>
      GifUploadDataModel(
        gifUrl: json["gifUrl"],
      );

  Map<String, dynamic> toJson() => {
        "gifUrl": gifUrl,
      };
}
