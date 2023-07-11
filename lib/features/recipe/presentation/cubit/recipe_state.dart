part of 'recipe_cubit.dart';

class RecipeState extends Equatable {
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
    final CubitStatus? status,
    final CubitStatus? showRecipeStatus,
    final List<RecipeModel>? recipes,
    final RecipeModel? recipe,
  }) {
    return RecipeState(
      recipe: recipe ?? this.recipe,
      status: status ?? this.status,
      showRecipeStatus: showRecipeStatus ?? this.showRecipeStatus,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object> get props => [status, recipes];

  @override
  String toString() => 'RecipeState(status: $status, recipes: $recipes)';
}
