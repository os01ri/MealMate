import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/helper/cubit_status.dart';
import '../../data/models/recipe_model.dart';
import '../../data/repositories/recipe_repository_impl.dart';
import '../../domain/usecases/index_recipes_usecase.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final _index = IndexRecipesUseCase(repository: RecipeRepositoryImpl());

  RecipeCubit() : super(const RecipeState());

  indexRecipes(IndexRecipesParams params) async {
    emit(state.copyWith(status: CubitStatus.loading, recipes: []));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(status: CubitStatus.failure)),
      (r) => emit(state.copyWith(status: CubitStatus.success, recipes: r.data)),
    );
  }
}
