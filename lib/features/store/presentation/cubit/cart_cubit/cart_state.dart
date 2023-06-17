part of 'cart_cubit.dart';

enum OrderStatus { init, cart, placed, failed }

class CartState {
  final List<CartItemModel> cartItems;
  final OrderStatus orderStatus;

  const CartState({
    this.cartItems = const [],
    this.orderStatus = OrderStatus.init,
  });

  CartState copyWith({
    List<CartItemModel>? cartItems,
    OrderStatus? orderStatus,
  }) {
    return CartState(
      cartItems: cartItems ?? this.cartItems,
      orderStatus: orderStatus ?? this.orderStatus,
    );
  }

  String getTotalPrice() {
    return cartItems
        .fold<int>(
          0,
          (v, e) => v + (e.model!.price! * e.quantity),
        )
        .numberFormat();
  }
}
