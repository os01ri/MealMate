part of 'recipe_cubit.dart';

class RecipeState {
  final CubitStatus status;
  final CubitStatus showRecipeStatus;
  final List<RecipeModel> recipes;
  final RecipeModel? recipe;

  const RecipeState({
    this.status = CubitStatus.initial,
    this.showRecipeStatus = CubitStatus.initial,
    this.recipes = const [],
    this.recipe,
  });

  RecipeState copyWith({
    CubitStatus? status,
    CubitStatus? showRecipeStatus,
    List<RecipeModel>? recipes,
    RecipeModel? recipe,
  }) {
    return RecipeState(
      status: status ?? this.status,
      showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
      recipes: recipes ?? this.recipes,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  String toString() => 'RecipeState(status: $status, recipes: $recipes)';
}
