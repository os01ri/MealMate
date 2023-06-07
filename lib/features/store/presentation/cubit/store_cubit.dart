import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate/core/helper/cubit_status.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/index_wishlist_items_response_model.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/index_ingredients_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/index_wishlist_usecase.dart';
import 'package:mealmate/features/store/domain/usecases/show_ingredient_usecase.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _index = IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  final _show = ShowIngredientUseCase(repository: StoreRepositoryImpl());
  final _indexWishlist = IndexWishlistUseCase(repository: StoreRepositoryImpl());
  final _addToWishlist = AddToWishlistUseCase(repository: StoreRepositoryImpl());

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

  getWishlist(IndexWishlistParams params) async {
    emit(state.copyWith(indexWishlistStatus: CubitStatus.loading));

    final result = await _indexWishlist(params);

    result.fold(
      (l) {
        log('fail');
        emit(state.copyWith(indexWishlistStatus: CubitStatus.failure));
      },
      (r) {
        log('succ');
        emit(state.copyWith(indexWishlistStatus: CubitStatus.success, wishItems: r.items));
      },
    );
  }

  addToWishlist(AddToWishlistParams params) async {
    emit(state.copyWith(addToWishlistStatus: CubitStatus.loading));

    final result = await _addToWishlist(params);

    result.fold(
      (l) {
        log('fail');
        emit(state.copyWith(addToWishlistStatus: CubitStatus.failure));
      },
      (r) {
        log('succ');
        emit(state.copyWith(addToWishlistStatus: CubitStatus.success));
      },
    );
  }
}
