part of 'control_panel_cubit.dart';

class ControlPanelState {
  final CubitStatus recipesStatus;
  final List<RecipeModel> recipes;

  final CubitStatus getUserInfoStatus;
  final UserModel? user;

  final CubitStatus updateUserInfoStatus;

  const ControlPanelState({
    this.recipesStatus = CubitStatus.initial,
    this.recipes = const [],
    this.getUserInfoStatus = CubitStatus.initial,
    this.user,
    this.updateUserInfoStatus = CubitStatus.initial,
  });

  ControlPanelState copyWith({
    CubitStatus? recipesStatus,
    List<RecipeModel>? recipes,
    CubitStatus? getUserInfoStatus,
    UserModel? user,
    CubitStatus? updateUserInfoStatus,
  }) {
    return ControlPanelState(
      recipesStatus: recipesStatus ?? this.recipesStatus,
      recipes: recipes ?? this.recipes,
      getUserInfoStatus: getUserInfoStatus ?? this.getUserInfoStatus,
      user: user ?? this.user,
      updateUserInfoStatus: updateUserInfoStatus ?? this.updateUserInfoStatus,
    );
  }
}
