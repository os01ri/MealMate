import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';
import 'package:mealmate/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:mealmate/features/recipe/domain/usecases/index_recipes_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _index = IndexRecipesUseCase(recipeRepository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());

  indexRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(
      status: CubitStatus.loading,
      recipes: [],
    ));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(status: CubitStatus.failure)),
      (r) => emit(state.copyWith(
        status: CubitStatus.success,
        recipes: r,
      )),
    );
  }
}
