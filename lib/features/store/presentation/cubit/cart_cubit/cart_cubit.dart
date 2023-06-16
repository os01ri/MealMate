// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:mealmate/features/store/data/models/cart_item_model.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/place_order_usecase.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  PlaceOrderUseCase placeOrder = PlaceOrderUseCase(repository: StoreRepositoryImpl());

  CartCubit() : super(const CartState());

  addOrUpdateProduct(
      {required IngredientModel ingredient, required int quantity}) {
    if (state.cartItems.map((e) => e.model!.id).toList().contains(ingredient.id)) {
      final items = state.cartItems;
      for (int i = 0; i < items.length; i++) {
        if (items[i].model!.id == ingredient.id) {
          items[i].quantity++;
        }
      }
      emit(state.copyWith(cartItems: items));
    } else {
      emit(state.copyWith(
          cartItems: List.of(state.cartItems)
            ..add(CartItemModel(model: ingredient, quantity: quantity))));
    }
  }

  deleteProduct({required IngredientModel ingredient, bool remove = false}) {
    if (state.cartItems.map((e) => e.model!.id!).toList().contains(ingredient.id)) {
      final items = state.cartItems;
      for (int i = 0; i < items.length; i++) {
        if (items[i].model!.id == ingredient.id) {
          items[i].quantity--;
          if (items[i].quantity <= 0 || remove) {
            items.removeAt(i);
          }
        }
      }
      
      emit(state.copyWith(cartItems: items));
    }
  }

  // getCartLocal(){}
  placeOrderToState({required PlaceOrderParams params}) async {
    final result = await placeOrder.call(params);
    result.fold((l) => emit(state.copyWith(orderStatus: OrderStatus.failed)), (r) {
      emit(state.copyWith(cartItems: [], orderStatus: OrderStatus.placed));
      emit(state.copyWith(orderStatus: OrderStatus.init));
    });
  }
}
