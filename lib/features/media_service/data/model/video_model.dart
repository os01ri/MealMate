import 'dart:convert';

VideoUploadModelResponse videoUploadModelResponseFromJson(String str) =>
    VideoUploadModelResponse.fromJson(json.decode(str));

String videoUploadModelResponseToJson(VideoUploadModelResponse data) =>
    json.encode(data.toJson());

class VideoUploadModelResponse {
  VideoUploadModelResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  VideoUploadDataModel? data;

  VideoUploadModelResponse copyWith({
    bool? success,
    String? message,
    VideoUploadDataModel? data,
  }) =>
      VideoUploadModelResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory VideoUploadModelResponse.fromJson(Map<String, dynamic> json) =>
      VideoUploadModelResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? null
            : VideoUploadDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class VideoUploadDataModel {
  VideoUploadDataModel({
    this.videoUrl,
  });

  String? videoUrl;

  VideoUploadDataModel copyWith({
    String? videoUrl,
  }) =>
      VideoUploadDataModel(
        videoUrl: videoUrl ?? this.videoUrl,
      );

  factory VideoUploadDataModel.fromJson(Map<String, dynamic> json) =>
      VideoUploadDataModel(
        videoUrl: json["videoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "videoUrl": videoUrl,
      };
}
