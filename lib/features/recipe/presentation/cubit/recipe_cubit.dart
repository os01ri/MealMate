import 'package:bloc/bloc.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/usecases/add_recipe_usecase.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../../domain/usecases/show_recipe_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());
  final _show = ShowRecipeUseCase(repository: RecipeRepositoryImpl());
  final _add = AddRecipeUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());

  indexRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(indexRecipeStatus: CubitStatus.loading, recipes: []));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(indexRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexRecipeStatus: CubitStatus.success, recipes: r.data)),
    );
  }

  showRecipe(int id) async {
    emit(state.copyWith(showRecipeStatus: CubitStatus.loading));

    final result = await _show(id);

    result.fold(
      (l) => emit(state.copyWith(showRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(recipe: r.data!, showRecipeStatus: CubitStatus.success)),
    );
  }

  addRecipe(AddRecipeParams params) async {
    emit(state.copyWith(addRecipeStatus: CubitStatus.loading));

    final result = await _add(params);

    result.fold(
      (l) => emit(state.copyWith(addRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(addRecipeStatus: CubitStatus.success)),
    );
  }
}
