import 'package:bloc/bloc.dart';

import '../../../../../core/helper/cubit_status.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../recipe/data/models/recipe_model.dart';
import '../../../data/repositories/favorite_recipes_repository_impl.dart';
import '../../../domain/usecases/add_favorite_recipe_usecase.dart';
import '../../../domain/usecases/index_favorite_recipes_usecase.dart';
import '../../../domain/usecases/remove_favorite_recipe_usecase.dart';

part 'favorite_recipes_state.dart';

class FavoriteRecipesCubit extends Cubit<FavoriteRecipesState> {
  final _index = IndexFavoriteRecipesUsecase(repository: FavoriteRecipesRepositoryImpl());
  final _add = AddFavoriteRecipeUsecase(repository: FavoriteRecipesRepositoryImpl());
  final _delete = RemoveFavoriteRecipeUsecase(repository: FavoriteRecipesRepositoryImpl());

  FavoriteRecipesCubit() : super(const FavoriteRecipesState());

  indexFavoriteRecipes() async {
    emit(state.copyWith(indexStatus: CubitStatus.loading));

    final result = await _index(NoParams());

    result.fold(
      (l) => emit(state.copyWith(indexStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexStatus: CubitStatus.success, favoriteRecipes: r.data!.likedRecipes)),
    );
  }

  addFavoriteRecipe(AddFavoriteRecipeParams params) async {
    emit(state.copyWith(addStatus: CubitStatus.loading));

    final result = await _add(params);

    result.fold(
      (l) => emit(state.copyWith(addStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(addStatus: CubitStatus.success)),
    );
    emit(state.copyWith(addStatus: CubitStatus.initial));
  }

  removeFavoriteRecipe(RemoveFavoriteRecipeParams params) async {
    emit(state.copyWith(deleteStatus: CubitStatus.loading));

    final result = await _delete(params);

    result.fold(
      (l) => emit(state.copyWith(deleteStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(deleteStatus: CubitStatus.success)),
    );
    emit(state.copyWith(deleteStatus: CubitStatus.initial));
  }
}
