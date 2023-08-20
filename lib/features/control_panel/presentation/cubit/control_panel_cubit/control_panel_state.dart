part of 'control_panel_cubit.dart';

class ControlPanelState {
  final CubitStatus recipesStatus;
  final List<RecipeModel> recipes;

  final CubitStatus getUserInfoStatus;
  final UserModel? user;

  final CubitStatus updateUserInfoStatus;
  final CubitStatus followersStatus;
  final CubitStatus indexRestrictionsStatus;

  final List<UserModel> followers;
  final List<UserModel> followings;
  final List<RestrictionModel> restrictions;

  const ControlPanelState({
    this.recipesStatus = CubitStatus.initial,
    this.indexRestrictionsStatus = CubitStatus.initial,
    this.recipes = const [],
    this.restrictions = const [],
    this.getUserInfoStatus = CubitStatus.initial,
    this.user,
    this.updateUserInfoStatus = CubitStatus.initial,
    this.followersStatus = CubitStatus.initial,
    this.followers = const [],
    this.followings = const [],
  });

  ControlPanelState copyWith({
    CubitStatus? recipesStatus,
    List<RecipeModel>? recipes,
    CubitStatus? getUserInfoStatus,
    UserModel? user,
    CubitStatus? updateUserInfoStatus,
    CubitStatus? followersStatus,
    CubitStatus? indexRestrictionsStatus,
    List<UserModel>? followers,
    List<UserModel>? followings,
    List<RestrictionModel>? restrictions,
  }) {
    return ControlPanelState(
      recipesStatus: recipesStatus ?? this.recipesStatus,
      recipes: recipes ?? this.recipes,
      getUserInfoStatus: getUserInfoStatus ?? this.getUserInfoStatus,
      user: user ?? this.user,
      updateUserInfoStatus: updateUserInfoStatus ?? this.updateUserInfoStatus,
      followersStatus: followersStatus ?? this.followersStatus,
      indexRestrictionsStatus:
          indexRestrictionsStatus ?? this.indexRestrictionsStatus,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      restrictions: restrictions ?? this.restrictions,
    );
  }
}
