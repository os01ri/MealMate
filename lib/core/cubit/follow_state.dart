part of 'follow_cubit.dart';

class FollowState {
  const FollowState({this.followStatus = CubitStatus.initial});

  final CubitStatus followStatus;

  FollowState copyWith({
    CubitStatus? followStatus,
  }) {
    return FollowState(
      followStatus: followStatus ?? this.followStatus,
    );
  }
}
