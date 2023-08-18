part of 'recipe_cubit.dart';

class RecipeState {
  final CubitStatus indexCategoriesStatus;
  final CubitStatus indexTypesStatus;

  final CubitStatus indexRecipeStatus;
  final CubitStatus indexTrendingRecipeStatus;
  final CubitStatus indexMostRatedRecipeStatus;
  final CubitStatus indexByFollowingRecipeStatus;
  final CubitStatus showRecipeStatus;
  final CubitStatus addRecipeStatus;
  final CubitStatus cookRecipeStatus;
  final CubitStatus rateRecipeStatus;

  final List<RecipeModel> recipes;
  final List<RecipeModel> trendingRecipes;
  final List<RecipeModel> mostRatedRecipes;
  final List<RecipeModel> followingsRecipes;

  final List<IngredientModel> ingredients;
  final List<CartItemModel> recipeIngredients;
  final RecipeModel? recipe;
  final List<RecipeStepModel> steps;
  final List<RecipeCategoryModel> categories;
  final List<RecipeCategoryModel> types;

  const RecipeState({
    this.categories = const [],
    this.types = const [],
    //
    this.ingredients = const [],
    this.recipeIngredients = const [],
    this.steps = const [],
    //
    this.recipes = const [],
    this.mostRatedRecipes = const [],
    this.followingsRecipes = const [],
    this.trendingRecipes = const [],
    //
    this.indexCategoriesStatus = CubitStatus.initial,
    this.indexTypesStatus = CubitStatus.initial,
    this.indexRecipeStatus = CubitStatus.initial,
    this.indexTrendingRecipeStatus = CubitStatus.initial,
    this.indexMostRatedRecipeStatus = CubitStatus.initial,
    this.indexByFollowingRecipeStatus = CubitStatus.initial,
    this.showRecipeStatus = CubitStatus.initial,
    this.addRecipeStatus = CubitStatus.initial,
    this.cookRecipeStatus = CubitStatus.initial,
    this.rateRecipeStatus = CubitStatus.initial,
    //
    this.recipe,
  });

  RecipeState copyWith({
    CubitStatus? indexCategoriesStatus,
    CubitStatus? indexTypesStatus,
    CubitStatus? indexRecipeStatus,
    CubitStatus? indexTrendingRecipeStatus,
    CubitStatus? indexMostRatedRecipeStatus,
    CubitStatus? indexByFollowingRecipeStatus,
    CubitStatus? showRecipeStatus,
    CubitStatus? addRecipeStatus,
    CubitStatus? cookRecipeStatus,
    CubitStatus? rateRecipeStatus,
    List<RecipeModel>? recipes,
    List<RecipeModel>? trendingRecipes,
    List<RecipeModel>? mostRatedRecipes,
    List<RecipeModel>? followingsRecipes,
    List<IngredientModel>? ingredients,
    List<CartItemModel>? recipeIngredients,
    RecipeModel? recipe,
    List<RecipeStepModel>? steps,
    List<RecipeCategoryModel>? categories,
    List<RecipeCategoryModel>? types,
  }) {
    return RecipeState(
      indexCategoriesStatus:
          indexCategoriesStatus ?? this.indexCategoriesStatus,
      indexTypesStatus: indexTypesStatus ?? this.indexTypesStatus,
      indexRecipeStatus: indexRecipeStatus ?? this.indexRecipeStatus,
      indexTrendingRecipeStatus:
          indexTrendingRecipeStatus ?? this.indexTrendingRecipeStatus,
      indexMostRatedRecipeStatus:
          indexMostRatedRecipeStatus ?? this.indexMostRatedRecipeStatus,
      indexByFollowingRecipeStatus:
          indexByFollowingRecipeStatus ?? this.indexByFollowingRecipeStatus,
      showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
      addRecipeStatus: addRecipeStatus ?? this.addRecipeStatus,
      cookRecipeStatus: cookRecipeStatus ?? this.cookRecipeStatus,
      rateRecipeStatus: rateRecipeStatus ?? this.rateRecipeStatus,
      recipes: recipes ?? this.recipes,
      trendingRecipes: trendingRecipes ?? this.trendingRecipes,
      mostRatedRecipes: mostRatedRecipes ?? this.mostRatedRecipes,
      followingsRecipes: followingsRecipes ?? this.followingsRecipes,
      ingredients: ingredients ?? this.ingredients,
      recipeIngredients: recipeIngredients ?? this.recipeIngredients,
      recipe: recipe ?? this.recipe,
      steps: steps ?? this.steps,
      categories: categories ?? this.categories,
      types: types ?? this.types,
    );
  }
}
