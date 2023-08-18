part of 'control_panel_cubit.dart';

class ControlPanelState {
  const ControlPanelState(
      {this.recipes = const [], this.status = CubitStatus.initial});
  final List<RecipeModel> recipes;
  final CubitStatus status;

  ControlPanelState copyWith({
    List<RecipeModel>? recipes,
    CubitStatus? status,
  }) {
    return ControlPanelState(
      recipes: recipes ?? this.recipes,
      status: status ?? this.status,
    );
  }
}
