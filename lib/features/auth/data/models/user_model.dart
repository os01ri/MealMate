import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({super.token, super.refreshToken, super.expiredAt});

  UserModel copyWith({
    String? token,
    int? expiredAt,
    String? refreshToken,
  }) =>
      UserModel(
        expiredAt: expiredAt ?? this.expiredAt,
        refreshToken: refreshToken ?? this.refreshToken,
        token: token ?? this.token,
      );
}
