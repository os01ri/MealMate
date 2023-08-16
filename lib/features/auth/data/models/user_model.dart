// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../store/data/models/index_ingredients_response_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final String? logo;
  final String? hash;
  final bool? status;
  final TokenInfo? tokenInfo;
  final int? followers;
  final int? following;
  final List<IngredientModel>? restrictedIngredients;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.logo,
    this.hash,
    this.status,
    this.tokenInfo,
    this.followers,
    this.following,
    this.restrictedIngredients,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? username,
    String? email,
    String? logo,
    String? hash,
    bool? status,
    TokenInfo? tokenInfo,
    int? followers,
    int? following,
    List<IngredientModel>? restrictedIngredients,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      logo: logo ?? this.logo,
      hash: hash ?? this.hash,
      status: status ?? this.status,
      tokenInfo: tokenInfo ?? this.tokenInfo,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      restrictedIngredients: restrictedIngredients ?? this.restrictedIngredients,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        logo: json["logo"],
        hash: json["hash"],
        status: json["status"],
        tokenInfo: json["token_info"] == null ? null : TokenInfo.fromJson(json["token_info"]),
        followers: json["followers"],
        following: json["following"],
        restrictedIngredients: json["unlikeingredient"] == null
            ? []
            : List<IngredientModel>.from(json["unlikeingredient"]!.map((x) => IngredientModel.fromJson(x))),
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
        "followers": followers,
        "following": following,
        "unlikeingredient":
            restrictedIngredients == null ? [] : List<dynamic>.from(restrictedIngredients!.map((x) => x.toJson())),
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
