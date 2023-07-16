// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_cubit.dart';

class RecipeState {
  final CubitStatus indexRecipeStatus;
  final CubitStatus showRecipeStatus;
  final CubitStatus addRecipeStatus;
  final List<RecipeModel> recipes;
  final List<IngredientModel> ingredients;
  final List<IngredientModel> recipeIngredients;
  final RecipeModel? recipe;

  const RecipeState({
    this.recipeIngredients = const [],
    this.ingredients = const [], 
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
    List<IngredientModel>? ingredients,
    List<IngredientModel>? recipeIngredients,
    RecipeModel? recipe,
  }) {
    return RecipeState(
      indexRecipeStatus: indexRecipeStatus ?? this.indexRecipeStatus,
      showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
      addRecipeStatus: addRecipeStatus ?? this.addRecipeStatus,
      recipes: recipes ?? this.recipes,
      ingredients: ingredients ?? this.ingredients,
      recipeIngredients: recipeIngredients ?? this.recipeIngredients,
      recipe: recipe ?? this.recipe,
    );
  }

  @override
  String toString() {
    return 'RecipeState(indexRecipeStatus: $indexRecipeStatus, showRecipeStatus: $showRecipeStatus, addRecipeStatus: $addRecipeStatus, recipes: $recipes, recipe: $recipe)';
  }
}
