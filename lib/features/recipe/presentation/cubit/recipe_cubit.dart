import 'package:bloc/bloc.dart';
import 'package:mealmate/features/recipe/data/models/recipe_step_model.dart';
import 'package:mealmate/features/recipe/domain/usecases/index_recipe_categories_usecase.dart';
import 'package:mealmate/features/recipe/domain/usecases/index_recipe_types_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../store/data/models/cart_item_model.dart';
import '../../../store/data/models/index_ingredients_response_model.dart';
import '../../../store/data/repositories/store_repository_impl.dart';
import '../../data/models/recipe_category_model.dart';
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
  final _indexIngredients =
      IndexIngredientsUseCase(repository: StoreRepositoryImpl());

  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());
  final _indexByFollowings =
      IndexRecipesByFollowingsUseCase(repository: RecipeRepositoryImpl());
  final _indexMostOrdered =
      IndexRecipesMostOrderedUseCase(repository: RecipeRepositoryImpl());
  final _indexTrending =
      IndexRecipesTrendingUseCase(repository: RecipeRepositoryImpl());

  final _indexRecipeCategoriesUseCase =
      IndexRecipeCategoriesUseCase(repository: RecipeRepositoryImpl());

  final _indexRecipeTypesUseCase =
      IndexRecipeTypesUseCase(repository: RecipeRepositoryImpl());

  final _show = ShowRecipeUseCase(repository: RecipeRepositoryImpl());
  final _add = AddRecipeUseCase(repository: RecipeRepositoryImpl());
  final _cook = CookRecipeUseCase(repository: RecipeRepositoryImpl());
  final _rate = RateRecipeUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(RecipeState());

  indexIngredients() async {
    final result = await _indexIngredients
        .call(const IndexIngredientsParams(page: 1, perPage: 100));
    result.fold((l) => indexIngredients(),
        (r) => emit(state.copyWith(ingredients: r.data!)));
    result.fold((l) => indexIngredients(),
        (r) => emit(state.copyWith(ingredients: r.data!)));
  }

  indexTypes() async {
    final types = await _indexRecipeTypesUseCase.call(NoParams());
    types.fold((l) => indexTypes(), (r) => emit(state.copyWith(types: r.data)));
  }

  indexCategories() async {
    final categories = await _indexRecipeCategoriesUseCase.call(NoParams());
    categories.fold((l) => indexCategories(),
        (r) => emit(state.copyWith(categories: r.data)));
  }

  addStepToRecipe(RecipeStepModel stepModel) {
    emit(state.copyWith(steps: List.of(state.steps)..add(stepModel)));
  }

  deleteStepFromRecipe(int rank) {
    emit(state.copyWith(
        steps: List.of(state.steps)
          ..removeWhere(
            (element) => element.rank == rank,
          )));
  }

  addOrUpdateIngredientToRecipe(CartItemModel ingredient) {
    if (state.recipeIngredients
        .map((e) => e.model!.id)
        .toList()
        .contains(ingredient.model!.id)) {
      final items = state.recipeIngredients;
      for (int i = 0; i < state.recipeIngredients.length; i++) {
        if (items[i].model!.id == ingredient.model!.id) {
          items[i].quantity = ingredient.quantity == items[i].quantity
              ? ingredient.quantity++
              : ingredient.quantity;
        }
      }
    } else {
      emit(state.copyWith(
          recipeIngredients: List.of(state.recipeIngredients)
            ..add(ingredient)));
    }
  }

  deleteIngredientFromRecipe(int id) {
    emit(state.copyWith(
        recipeIngredients: List.of(state.recipeIngredients)
          ..removeWhere((element) => element.model!.id == id)));
  }

  indexRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(indexRecipeStatus: CubitStatus.loading, recipes: []));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(indexRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          indexRecipeStatus: CubitStatus.success, recipes: r.data)),
    );
  }

  indexRecipesBuyFollowings(IndexRecipesParams params) async {
    emit(state.copyWith(
        indexByFollowingRecipeStatus: CubitStatus.loading,
        followingsRecipes: []));

    final result = await _indexByFollowings(params);

    result.fold(
      (l) => emit(
          state.copyWith(indexByFollowingRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          indexByFollowingRecipeStatus: CubitStatus.success,
          followingsRecipes: r.data)),
    );
  }

  indexRecipesTrending(IndexRecipesParams params) async {
    emit(state.copyWith(
        indexTrendingRecipeStatus: CubitStatus.loading, trendingRecipes: []));

    final result = await _indexTrending(params);

    result.fold(
      (l) =>
          emit(state.copyWith(indexTrendingRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          indexTrendingRecipeStatus: CubitStatus.success,
          trendingRecipes: r.data)),
    );
  }

  indexRecipesMostOrdered(IndexRecipesParams params) async {
    emit(state.copyWith(
        indexMostOrderedRecipeStatus: CubitStatus.loading,
        mostOrderedRecipes: []));

    final result = await _indexMostOrdered(params);

    result.fold(
      (l) => emit(
          state.copyWith(indexMostOrderedRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          indexMostOrderedRecipeStatus: CubitStatus.success,
          mostOrderedRecipes: r.data)),
    );
  }

  showRecipe(int id) async {
    emit(state.copyWith(showRecipeStatus: CubitStatus.loading));

    final result = await _show(id);

    result.fold(
      (l) => emit(state.copyWith(showRecipeStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
          recipe: r.data!.recipes!, showRecipeStatus: CubitStatus.success)),
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
