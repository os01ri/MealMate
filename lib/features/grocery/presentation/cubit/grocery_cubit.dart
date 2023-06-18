import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/repositories/grocery_repo_impl.dart';
import '../../domain/usecases/grocery_add_item.dart';
import '../../domain/usecases/grocery_delete_item.dart';
import '../../domain/usecases/index_grocery.dart';
import '../../../store/data/repositories/store_repository_impl.dart';
import '../../../store/domain/usecases/index_ingredients_categories_usecase.dart';
import '../../../store/domain/usecases/index_ingredients_usecase.dart';

import '../../data/models/index_grocery_response_model.dart';

part 'grocery_state.dart';

class GroceryCubit extends Cubit<GroceryState> {
  final storeItemInGrocery =
      StoreItemInGroceryUseCase(repository: GroceryRepoImpl());
  final deleteItemFromGrocery =
      DeleteItemFromGroceryUseCase(repository: GroceryRepoImpl());
  final indexGrocery = IndexGroceryUseCase(repository: GroceryRepoImpl());
  final indexIngredients =
      IndexIngredientsUseCase(repository: StoreRepositoryImpl());
  final indexIngredientsCategories =
      IndexIngredientsCategoriesUseCase(repository: StoreRepositoryImpl());
  GroceryCubit() : super(const GroceryState());
  getGroceryItems() async {
    emit(state.copyWith(status: GroceryStatus.loading, cartItems: []));
    final result = await indexGrocery.call(NoParams());
    result.fold(
        (l) => emit(state.copyWith(status: GroceryStatus.failed)),
        (r) => emit(
            state.copyWith(status: GroceryStatus.success, cartItems: r.data!)));
  }

  deleteGroceryItem(int id) async {
    emit(state.copyWith(
        deleteGroceryItemStatus: DeleteGroceryItemStatus.loading));
    final result = await deleteItemFromGrocery.call(id);
    result.fold((l) {
      emit(state.copyWith(
          deleteGroceryItemStatus: DeleteGroceryItemStatus.failed));
      emit(state.copyWith(
          deleteGroceryItemStatus: DeleteGroceryItemStatus.init));
    }, (r) {
      emit(state.copyWith(
          deleteGroceryItemStatus: DeleteGroceryItemStatus.success,
          cartItems: List.of(state.cartItems)
            ..removeWhere((element) => element.id == id)));
      emit(state.copyWith(
          deleteGroceryItemStatus: DeleteGroceryItemStatus.init));
    });
  }
}
