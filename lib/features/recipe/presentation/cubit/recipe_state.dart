part of 'recipe_cubit.dart';

class RecipeState extends Equatable {
  final CubitStatus status;
  final List<RecipeModel> recipes;

  const RecipeState({
    this.status = CubitStatus.initial,
    this.recipes = const [],
  });

  copyWith({
    final CubitStatus? status,
    final List<RecipeModel>? recipes,
  }) {
    return RecipeState(
      status: status ?? this.status,
      recipes: recipes ?? this.recipes,
    );
  }

  @override
  List<Object> get props => [status, recipes];

  @override
  String toString() => 'RecipeState(status: $status, recipes: $recipes)';
}
