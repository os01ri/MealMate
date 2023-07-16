import 'package:bloc/bloc.dart';
import '../../../../../core/helper/cubit_status.dart';
import '../../../data/models/index_ingredients_categories_response_model.dart';
import '../../../data/models/index_ingredients_response_model.dart';
import '../../../data/models/index_wishlist_items_response_model.dart';
import '../../../data/repositories/store_repository_impl.dart';
import '../../../domain/usecases/add_to_wishlist_usecase.dart';
import '../../../domain/usecases/index_ingredients_categories_usecase.dart';
import '../../../domain/usecases/index_ingredients_usecase.dart';
import '../../../domain/usecases/index_wishlist_usecase.dart';
import '../../../domain/usecases/remove_from_wishlist_usecase.dart';
import '../../../domain/usecases/show_ingredient_usecase.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final _indexCategories = IndexIngredientsCategoriesUseCase(repository: StoreRepositoryImpl());
  final _index = IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  final _show = ShowIngredientUseCase(repository: StoreRepositoryImpl());
  final _indexWishlist = IndexWishlistUseCase(repository: StoreRepositoryImpl());
  final _addToWishlist = AddToWishlistUseCase(repository: StoreRepositoryImpl());
  final _removeFromWishlist = RemoveFromWishlistUseCase(repository: StoreRepositoryImpl());

  StoreCubit() : super(const StoreState());

  getIngredientsCategories(IndexIngredientsCategoriesParams params) async {
    emit(state.copyWith(indexCategoriesStatus: CubitStatus.loading));

    final result = await _indexCategories(params);

    result.fold(
      (l) {
        emit(state.copyWith(indexCategoriesStatus: CubitStatus.failure));

      },
      (r) => emit(
        state.copyWith(
          indexCategoriesStatus: CubitStatus.success,
          ingredientsCategories: r.data!.categories!
            ..insert(
              0,
              IngredientCategoryModel(id: 0, name: 'الكل'),
            ),
        ),
      ),
    );
  }

  getIngredients(IndexIngredientsParams params) async {
    emit(state.copyWith(indexStatus: CubitStatus.loading, ingredients: []));

    final result = await _index(params);

    result.fold(
      (l) => emit(state.copyWith(indexStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexStatus: CubitStatus.success, ingredients: r.data)),
    );
  }

  showIngredient(ShowIngredientParams params) async {
    emit(state.copyWith(showStatus: CubitStatus.loading));

    final result = await _show(params);

    result.fold(
      (l) => emit(state.copyWith(showStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(showStatus: CubitStatus.success, ingredient: r.data)),
    );
  }

  getWishlist(IndexWishlistParams params) async {
    emit(state.copyWith(indexWishlistStatus: CubitStatus.loading));

    final result = await _indexWishlist(params);

    result.fold(
      (l) => emit(state.copyWith(indexWishlistStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(indexWishlistStatus: CubitStatus.success, wishItems: r.items)),
    );
  }

  addToWishlist(AddToWishlistParams params) async {
    emit(state.copyWith(addToWishlistStatus: CubitStatus.loading));

    final result = await _addToWishlist(params);

    result.fold(
      (l) => emit(state.copyWith(addToWishlistStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(addToWishlistStatus: CubitStatus.success)),
    );
  }

  removeFromWishlist(RemoveFromWishlistParams params) async {
    emit(state.copyWith(removeFromWishlistStatus: CubitStatus.loading));

    final result = await _removeFromWishlist(params);

    result.fold(
      (l) => emit(state.copyWith(removeFromWishlistStatus: CubitStatus.failure)),
      (r) => emit(state.copyWith(
        removeFromWishlistStatus: CubitStatus.success,
        wishItems: List.of(state.wishItems)..removeWhere((element) => element.id == params.ingredientId),
      )),
    );
  }
}
