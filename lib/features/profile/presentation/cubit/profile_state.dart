part of 'profile_cubit.dart';

class ProfileState {
  final CubitStatus showUserStatus;
  final ProfileModel? user;
  const ProfileState({
    this.showUserStatus = CubitStatus.initial,
    this.user,
  });

  ProfileState copyWith({
    CubitStatus? showUserStatus,
    ProfileModel? user,
  }) {
    return ProfileState(
      showUserStatus: showUserStatus ?? this.showUserStatus,
      user: user ?? this.user,
    );
  }
}
