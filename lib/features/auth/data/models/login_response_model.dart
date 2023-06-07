 
import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final bool? success;
  final String? message;
  final UserModel? data;

  const LoginResponseModel({
    this.success,
    this.message,
    this.data,
  });

  LoginResponseModel copyWith({
    bool? success,
    String? message,
    UserModel? data,
  }) =>
      LoginResponseModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final dynamic logo;
  final bool? status;
  final TokenInfo? tokenInfo;

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
    TokenInfo? tokenInfo,
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
        tokenInfo: json["token_info"] == null ? null : TokenInfo.fromJson(json["token_info"]),
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

class TokenInfo {
  final String? token;
  final String? refreshToken;
  final int? exipredAt;

  TokenInfo({
    this.token,
    this.refreshToken,
    this.exipredAt,
  });

  TokenInfo copyWith({
    String? token,
    String? refreshToken,
    int? exipredAt,
  }) =>
      TokenInfo(
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken,
        exipredAt: exipredAt ?? this.exipredAt,
      );

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
        token: json["token"],
        refreshToken: json["refreshToken"],
        exipredAt: json["exipred_at"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "refreshToken": refreshToken,
        "exipred_at": exipredAt,
      };
}
