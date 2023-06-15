import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final dynamic logo;
  final bool? status;
  final _TokenInfo? tokenInfo;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.status,
    this.tokenInfo,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    dynamic logo,
    bool? status,
    _TokenInfo? tokenInfo,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        logo: logo ?? this.logo,
        status: status ?? this.status,
        tokenInfo: tokenInfo ?? this.tokenInfo,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        status: json["status"],
        tokenInfo: json["token_info"] == null ? null : _TokenInfo.fromJson(json["token_info"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "logo": logo,
        "status": status,
        "token_info": tokenInfo?.toJson(),
      };
}

class _TokenInfo {
  final String? token;
  final String? refreshToken;
  final int? expiredAt;

  _TokenInfo({
    this.token,
    this.refreshToken,
    this.expiredAt,
  });

  _TokenInfo copyWith({
    String? token,
    String? refreshToken,
    int? expiredAt,
  }) =>
      _TokenInfo(
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken,
        expiredAt: expiredAt ?? this.expiredAt,
      );

  factory _TokenInfo.fromJson(Map<String, dynamic> json) => _TokenInfo(
        token: json["token"],
        refreshToken: json["refreshToken"],
        expiredAt: json["exipred_at"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
        "exipred_at": expiredAt,
      };
}
