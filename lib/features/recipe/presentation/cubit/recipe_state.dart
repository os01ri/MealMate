// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recipe_cubit.dart';

class RecipeState {
  final CubitStatus indexRecipeStatus;
  final CubitStatus indexTrendingRecipeStatus;
  final CubitStatus indexMostOrderedRecipeStatus;
  final CubitStatus indexByFollowingRecipeStatus;
  final CubitStatus showRecipeStatus;
  final CubitStatus addRecipeStatus;
  final CubitStatus cookRecipeStatus;
  final CubitStatus rateRecipeStatus;

  final List<RecipeModel> recipes;
  final List<RecipeModel> trendingRecipes;
  final List<RecipeModel> mostOrderedRecipes;
  final List<RecipeModel> followingsRecipes;

  final List<IngredientModel> ingredients;
  final List<CartItemModel> recipeIngredients;
  final RecipeModel? recipe;
  final List<RecipeStepModel> steps;
  final List<RecipeCategoryModel> categories;
  final List<RecipeCategoryModel> types;

  const RecipeState({
    this.recipeIngredients = const [],
    this.ingredients = const [],
    this.steps = const [],
    this.types = const [],
    this.categories = const [],
    this.indexRecipeStatus = CubitStatus.initial,
    this.indexTrendingRecipeStatus = CubitStatus.initial,
    this.indexMostOrderedRecipeStatus = CubitStatus.initial,
    this.indexByFollowingRecipeStatus = CubitStatus.initial,
    this.showRecipeStatus = CubitStatus.initial,
    this.addRecipeStatus = CubitStatus.initial,
    this.cookRecipeStatus = CubitStatus.initial,
    this.rateRecipeStatus = CubitStatus.initial,
    this.recipes = const [],
    this.mostOrderedRecipes = const [],
    this.followingsRecipes = const [],
    this.trendingRecipes = const [],
    this.recipe,
  });

  RecipeState copyWith({
    CubitStatus? indexRecipeStatus,
    CubitStatus? indexTrendingRecipeStatus,
    CubitStatus? indexMostOrderedRecipeStatus,
    CubitStatus? indexByFollowingRecipeStatus,
    CubitStatus? showRecipeStatus,
    List<RecipeCategoryModel>? categories,
    List<RecipeCategoryModel>? types,
    CubitStatus? addRecipeStatus,
    CubitStatus? cookRecipeStatus,
    CubitStatus? rateRecipeStatus,
    List<RecipeModel>? recipes,
    List<RecipeModel>? trendingRecipes,
    List<RecipeModel>? mostOrderedRecipes,
    List<RecipeModel>? followingsRecipes,
    RecipeModel? recipe,
    List<IngredientModel>? ingredients,
    List<CartItemModel>? recipeIngredients,
    List<RecipeStepModel>? steps,
  }) {
    return RecipeState(
        steps: steps ?? this.steps,
        categories: categories ?? this.categories,
        types: types ?? this.types,
        indexRecipeStatus: indexRecipeStatus ?? this.indexRecipeStatus,
        indexTrendingRecipeStatus:
            indexTrendingRecipeStatus ?? this.indexTrendingRecipeStatus,
        indexMostOrderedRecipeStatus:
            indexMostOrderedRecipeStatus ?? this.indexMostOrderedRecipeStatus,
        indexByFollowingRecipeStatus:
            indexByFollowingRecipeStatus ?? this.indexByFollowingRecipeStatus,
        showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
        addRecipeStatus: addRecipeStatus ?? this.addRecipeStatus,
        cookRecipeStatus: cookRecipeStatus ?? this.cookRecipeStatus,
        rateRecipeStatus: rateRecipeStatus ?? this.rateRecipeStatus,
        recipes: recipes ?? this.recipes,
        trendingRecipes: trendingRecipes ?? this.trendingRecipes,
        mostOrderedRecipes: mostOrderedRecipes ?? this.mostOrderedRecipes,
        followingsRecipes: followingsRecipes ?? this.followingsRecipes,
        recipe: recipe ?? this.recipe,
        ingredients: ingredients ?? this.ingredients,
        recipeIngredients: recipeIngredients ?? this.recipeIngredients);
  }
}
