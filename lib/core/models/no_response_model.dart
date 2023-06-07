import 'dart:convert';

NoResponse noResponseFromJson(String str) => NoResponse.fromJson(json.decode(str));

String noResponseToJson(NoResponse data) => json.encode(data.toJson());

class NoResponse {
  NoResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  dynamic data;

  NoResponse copyWith({
    bool? success,
    String? message,
    dynamic data,
  }) =>
      NoResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory NoResponse.fromJson(Map<String, dynamic> json) => NoResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
