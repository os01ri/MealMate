import 'package:bloc/bloc.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../../../store/data/repositories/store_repository_impl.dart';
import '../../../store/domain/usecases/index_ingredients_usecase.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/usecases/add_recipe_usecase.dart';
import '../../domain/usecases/cook_recipe_usecase.dart';
import '../../domain/usecases/index_recipes_by_following_usecase.dart';
import '../../domain/usecases/index_recipes_most_ordered_usecase.dart';
import '../../domain/usecases/index_recipes_trending_usecase.dart';
import '../../domain/usecases/index_recipes_usecase.dart';
import '../../domain/usecases/rate_recipe_usecase.dart';
import '../../domain/usecases/show_recipe_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _indexIngredients = IndexIngredientsUseCase(repository: StoreRepositoryImpl());

  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());
  final _indexByFollowings = IndexRecipesByFollowingsUseCase(repository: RecipeRepositoryImpl());
  final _indexMostOrdered = IndexRecipesMostOrderedUseCase(repository: RecipeRepositoryImpl());
  final _indexTrending = IndexRecipesTrendingUseCase(repository: RecipeRepositoryImpl());
  final _show = ShowRecipeUseCase(repository: RecipeRepositoryImpl());
  final _add = AddRecipeUseCase(repository: RecipeRepositoryImpl());
  final _cook = CookRecipeUseCase(repository: RecipeRepositoryImpl());
  final _rate = RateRecipeUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());

  indexIngredients() async {
    final result = await _indexIngredients.call(const IndexIngredientsParams(page: 1, perPage: 100));
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

  indexRecipesBuyFollowings(IndexRecipesParams params) async {
    emit(state.copyWith(indexByFollowingRecipeStatus: CubitStatus.loading, followingsRecipes: []));

    final result = await _indexByFollowings(params);

    result.fold(
      (l) => emit(state.copyWith(indexByFollowingRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexByFollowingRecipeStatus: CubitStatus.success, followingsRecipes: r.data)),
    );
  }

  indexRecipesTrending(IndexRecipesParams params) async {
    emit(state.copyWith(indexTrendingRecipeStatus: CubitStatus.loading, trendingRecipes: []));

    final result = await _indexTrending(params);

    result.fold(
      (l) => emit(state.copyWith(indexTrendingRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexTrendingRecipeStatus: CubitStatus.success, trendingRecipes: r.data)),
    );
  }

  indexRecipesMostOrdered(IndexRecipesParams params) async {
    emit(state.copyWith(indexMostOrderedRecipeStatus: CubitStatus.loading, mostOrderedRecipes: []));

    final result = await _indexMostOrdered(params);

    result.fold(
      (l) => emit(state.copyWith(indexMostOrderedRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexMostOrderedRecipeStatus: CubitStatus.success, mostOrderedRecipes: r.data)),
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

  cookRecipe(CookRecipeParams params) async {
    emit(state.copyWith(cookRecipeStatus: CubitStatus.loading));

    final result = await _cook(params);

    result.fold(
      (l) => emit(state.copyWith(cookRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(cookRecipeStatus: CubitStatus.success)),
    );
  }

  rateRecipe(RateRecipeParams params) async {
    emit(state.copyWith(rateRecipeStatus: CubitStatus.loading));

    final result = await _rate(params);

    result.fold(
      (l) => emit(state.copyWith(rateRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(rateRecipeStatus: CubitStatus.success)),
    );
  }
}
