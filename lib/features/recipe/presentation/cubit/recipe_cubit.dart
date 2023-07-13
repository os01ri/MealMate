import 'package:bloc/bloc.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../../domain/usecases/show_recipe_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());
  final _showRecipeUseCase = ShowRecipeUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());

  indexRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading, recipes: []));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(status: CubitStatus.failure)),
      (r) => emit(state.copyWith(status: CubitStatus.success, recipes: r.data)),
    );
  }

  showRecipe(int id) async {
    emit(state.copyWith(showRecipeStatus: CubitStatus.loading));

    final result = await _showRecipeUseCase(id);

    result.fold(
      (l) => emit(state.copyWith(showRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(recipe: r.data!, showRecipeStatus: CubitStatus.success)),
    );
  }
}
