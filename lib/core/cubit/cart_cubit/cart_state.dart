// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

class CartState {
  final List<CartItem> cartItems;
  CartState({this.cartItems = const []});

  CartState copyWith({
    List<CartItem>? cartItems,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
