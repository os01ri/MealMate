import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic logo;
  final dynamic hash;
  final bool? status;
  final TokenInfo? tokenInfo;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.logo,
    this.hash,
    this.status,
    this.tokenInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        logo: json["logo"],
        hash: json["hash"],
        status: json["status"],
        tokenInfo: json["token_info"] == null
            ? null
            : TokenInfo.fromJson(json["token_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "logo": logo,
        "hash": hash,
        "status": status,
        "token_info": tokenInfo?.toJson(),
      };
}

class TokenInfo {
  final String? token;
  final String? refreshToken;
  final int? expiredAt;

  TokenInfo({
    this.token,
    this.refreshToken,
    this.expiredAt,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        token: json["token"],
        refreshToken: json["refreshToken"],
        expiredAt: json["expired_at"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
        "expired_at": expiredAt,
      };
}
