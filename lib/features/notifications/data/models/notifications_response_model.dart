import 'dart:convert';

NotificationsResponseModel notificationsResponseModelFromJson(String str) =>
    NotificationsResponseModel.fromJson(json.decode(str));

String notificationsResponseModelToJson(NotificationsResponseModel data) => json.encode(data.toJson());

class NotificationsResponseModel {
  final String? message;
  final List<NotificationModel>? data;
  final bool? success;

  const NotificationsResponseModel({
    this.message,
    this.data,
    this.success,
  });

  NotificationsResponseModel copyWith({
    String? message,
    List<NotificationModel>? data,
    bool? success,
  }) =>
      NotificationsResponseModel(
        message: message ?? this.message,
        data: data ?? this.data,
        success: success ?? this.success,
      );

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) => NotificationsResponseModel(
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "success": success,
      };
}

class NotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NotificationModel({
    this.id,
    this.title,
    this.body,
    this.createdAt,
    this.updatedAt,
  });

  NotificationModel copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
