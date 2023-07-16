import 'package:bloc/bloc.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../../../store/data/repositories/store_repository_impl.dart';
import '../../../store/domain/repositories/store_repository.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/usecases/add_recipe_usecase.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../../domain/usecases/show_recipe_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());
  final _indexingredients = IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  final _show = ShowRecipeUseCase(repository: RecipeRepositoryImpl());
  final _add = AddRecipeUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());
  indexIngredients() async {
    final result = await _indexingredients.call(IndexIngredientsParams(page: 1, perPage: 100));
    result.fold((l) => indexIngredients(), (r) => emit(state.copyWith(ingredients: r.data!)));
  }

  addIngredientToRecipe(IngredientModel ingredient) {
    emit(state.copyWith(recipeIngredients: List.of(state.recipeIngredients)..add(ingredient)));
  }

  deleteIngredientFromRecipe(int id) {
    emit(state.copyWith(
        recipeIngredients: List.of(state.recipeIngredients)..removeWhere((element) => element.id == id)));
  }

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
      (r) => emit(state.copyWith(recipe: r.data!.recipes!, showRecipeStatus: CubitStatus.success)),
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
