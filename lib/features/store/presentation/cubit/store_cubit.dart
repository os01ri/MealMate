import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/features/store/data/models/ingredient_model.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _indexIngredients = IndexIngredientsUseCase(storeRepository: StoreRepositoryImpl());

  StoreCubit() : super(const StoreState());

  getIngredients(IndexIngredientsParams params) async {
    emit(state.copyWith(status: CubitStatus.loading));

    final result = await _indexIngredients(params);

    result.fold(
      (l) {
        log('fail');
        emit(state.copyWith(status: CubitStatus.failure));
      },
      (r) {
        log('succ');
        emit(state.copyWith(status: CubitStatus.success, ingredients: r.data));
      },
    );
  }
}
