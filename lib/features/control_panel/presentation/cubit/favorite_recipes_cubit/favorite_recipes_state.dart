part of 'favorite_recipes_cubit.dart';

class FavoriteRecipesState {
  final CubitStatus indexStatus;
  final CubitStatus addStatus;
  final CubitStatus deleteStatus;

  final List<RecipeModel> favoriteRecipes;

  const FavoriteRecipesState({
    this.indexStatus = CubitStatus.initial,
    this.addStatus = CubitStatus.initial,
    this.deleteStatus = CubitStatus.initial,
    this.favoriteRecipes = const [],
  });

  FavoriteRecipesState copyWith({
    CubitStatus? indexStatus,
    CubitStatus? addStatus,
    CubitStatus? deleteStatus,
    List<RecipeModel>? favoriteRecipes,
  }) {
    return FavoriteRecipesState(
      indexStatus: indexStatus ?? this.indexStatus,
      addStatus: addStatus ?? this.addStatus,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      favoriteRecipes: favoriteRecipes ?? this.favoriteRecipes,
    );
  }
}
