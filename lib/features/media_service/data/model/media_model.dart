import 'dart:convert';

MediaModel mediaModelFromJson(String str) => MediaModel.fromJson(json.decode(str));

String mediaModelToJson(MediaModel data) => json.encode(data.toJson());

class MediaModel {
  MediaModel({
    this.id,
    this.mediaUrl,
    this.thumbUrl,
    this.mediaType,
    this.hash,
    this.order,
  });
  final int? id;
  final String? mediaUrl;
  final String? thumbUrl;
  final int? mediaType;
  final String? hash;
  final int? order;

  MediaModel copyWith({
    int? id,
    String? mediaUrl,
    String? thumbUrl,
    int? mediaType,
    String? hash,
    int? order,
  }) =>
      MediaModel(
        id: id ?? this.id,
        mediaUrl: mediaUrl ?? this.mediaUrl,
        thumbUrl: thumbUrl ?? this.thumbUrl,
        mediaType: mediaType ?? this.mediaType,
        hash: hash ?? this.hash,
        order: order ?? this.order,
      );

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        id: json["id"],
        mediaUrl: json["media_url"],
        thumbUrl: json["thumb_url"] ?? json["media_url"],
        mediaType: json["media_type"],
        hash: json["hash"],
        order: json["order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "media_url": mediaUrl,
        "thumb_url": thumbUrl,
        "media_type": mediaType,
        "hash": hash,
        "order": order,
      };

  @override
  bool operator ==(covariant MediaModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.mediaUrl == mediaUrl &&
        other.thumbUrl == thumbUrl &&
        other.mediaType == mediaType &&
        other.hash == hash &&
        other.order == order;
  }

  @override
  int get hashCode {
    return id.hashCode ^ mediaUrl.hashCode ^ thumbUrl.hashCode ^ mediaType.hashCode ^ hash.hashCode ^ order.hashCode;
  }
}
