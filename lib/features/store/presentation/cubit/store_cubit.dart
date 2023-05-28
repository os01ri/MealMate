import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/show_ingredient_usecase.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _index = IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  final _show = ShowIngredientUseCase(repository: StoreRepositoryImpl());

  StoreCubit() : super(const StoreState());

  getIngredients(IndexIngredientsParams params) async {
    emit(state.copyWith(indexStatus: CubitStatus.loading));

    final result = await _index(params);

    result.fold(
      (l) {
        log('fail');
        emit(state.copyWith(indexStatus: CubitStatus.failure));
      },
      (r) {
        log('succ');
        emit(state.copyWith(indexStatus: CubitStatus.success, ingredients: r.data));
      },
    );
  }

  showIngredient(ShowIngredientParams params) async {
    emit(state.copyWith(showStatus: CubitStatus.loading));

    final result = await _show(params);

    result.fold(
      (l) {
        log('fail');
        emit(state.copyWith(showStatus: CubitStatus.failure));
      },
      (r) {
        log('succ');
        emit(state.copyWith(showStatus: CubitStatus.success, ingredient: r.data));
      },
    );
  }
}
