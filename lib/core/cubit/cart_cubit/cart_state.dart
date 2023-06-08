// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState {
  final List<IngredientModel> cartItems;
  CartState({this.cartItems = const []});

  CartState copyWith({
    List<IngredientModel>? cartItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
