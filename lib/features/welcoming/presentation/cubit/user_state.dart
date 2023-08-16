part of 'user_cubit.dart';

class UserState {
  final CubitStatus userInfoStatus;
  final UserModel? user;

  const UserState({
    this.userInfoStatus = CubitStatus.initial,
    this.user,
  });

  UserState copyWith({
    CubitStatus? userInfoStatus,
    UserModel? user,
  }) {
    return UserState(
      userInfoStatus: userInfoStatus ?? this.userInfoStatus,
      user: user ?? this.user,
    );
  }
}
