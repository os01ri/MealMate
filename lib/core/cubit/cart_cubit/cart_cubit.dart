
import 'package:bloc/bloc.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());
  addOrUpdateProduct({required IngredientModel ingredient}) {
if (state.cartItems.map((e) => e.model).toList().contains(ingredient)) {
      final items = state.cartItems;
      for (int i = 0; i < items.length; i++) {
        if (items[i].model == ingredient) {
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
    if (state.cartItems.map((e) => e.model).toList().contains(ingredient)) {
      final items = state.cartItems;
      for (int i = 0; i < items.length; i++) {
        if (items[i].model == ingredient) {
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
