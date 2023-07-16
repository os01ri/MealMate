// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_cubit.dart';

class RecipeState {
  final CubitStatus indexRecipeStatus;
  final CubitStatus showRecipeStatus;
  final CubitStatus addRecipeStatus;
  final List<RecipeModel> recipes;
  final RecipeModel? recipe;

  const RecipeState({
    this.indexRecipeStatus = CubitStatus.initial,
    this.showRecipeStatus = CubitStatus.initial,
    this.addRecipeStatus = CubitStatus.initial,
    this.recipes = const [],
    this.recipe,
  });

  RecipeState copyWith({
    CubitStatus? indexRecipeStatus,
    CubitStatus? showRecipeStatus,
    CubitStatus? addRecipeStatus,
    List<RecipeModel>? recipes,
    RecipeModel? recipe,
  }) {
    return RecipeState(
      indexRecipeStatus: indexRecipeStatus ?? this.indexRecipeStatus,
      showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
      addRecipeStatus: addRecipeStatus ?? this.addRecipeStatus,
      recipes: recipes ?? this.recipes,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  String toString() {
    return 'RecipeState(indexRecipeStatus: $indexRecipeStatus, showRecipeStatus: $showRecipeStatus, addRecipeStatus: $addRecipeStatus, recipes: $recipes, recipe: $recipe)';
  }
}
