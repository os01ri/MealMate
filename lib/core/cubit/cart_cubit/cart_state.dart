// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cart_cubit.dart';

enum OrderStatus { init, cart, placed, failed }
class CartState {
  final List<CartItem> cartItems;
  final OrderStatus orderStatus;
  CartState({this.cartItems = const [], this.orderStatus = OrderStatus.init});

  CartState copyWith({
    List<CartItem>? cartItems,
    OrderStatus? orderStatus
  }) {
    return CartState(
      orderStatus: orderStatus ?? this.orderStatus,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
