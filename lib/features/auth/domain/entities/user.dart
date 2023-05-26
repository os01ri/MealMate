import 'dart:convert';

User userModelFromJson(String str) => User.fromJson(json.decode(str));

String userModelToJson(User data) => json.encode(data.toJson());

class User {
  final String? token;
  final String? refreshToken;
  final int? expiredAt;

  User({
    required this.token,
    required this.refreshToken,
    required this.expiredAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
