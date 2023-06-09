import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/repositories/store_repository_impl.dart';
import 'package:mealmate/features/store/domain/usecases/place_order.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
PlaceOrderUseCase placeOrder =
      PlaceOrderUseCase(repository: StoreRepositoryImpl());


  CartCubit() : super(CartState());
  addOrUpdateProduct({required IngredientModel ingredient}) {
if (state.cartItems
        .map((e) => e.model!.id)
        .toList()
        .contains(ingredient.id)) {
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
            ..add(CartItem(model: ingredient, quantity: 1))));
    }
  }

  deleteProduct({required IngredientModel ingredient}) {
    if (state.cartItems
        .map((e) => e.model!.id!)
        .toList()
        .contains(ingredient.id)) {
      final items = state.cartItems;
      for (int i = 0; i < items.length; i++) {
        if (items[i].model!.id == ingredient.id) {
          items[i].quantity--;
          if (items[i].quantity <= 0) {
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
    result.fold((l) => emit(state.copyWith(orderStatus: OrderStatus.failed)),
        (r) {
      emit(state.copyWith(cartItems: [], orderStatus: OrderStatus.placed));
      emit(state.copyWith(orderStatus: OrderStatus.init));
    });
  }

}

class CartItem {
  IngredientModel? model;
  int quantity;
  

  CartItem({
    this.model,
    this.quantity = 1,
  });

  CartItem copyWith({
    int? quantity, IngredientModel? model
  }) {
    return CartItem(
      model: model ?? this.model,
      quantity: quantity ?? this.quantity,
    );
  }
}
