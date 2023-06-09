// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    return intl.NumberFormat(',###' * 10).format(
      cartItems.fold<int>(
        0,
        (v, e) => v + (e.model!.price! * e.quantity),
      ),
    );
  }
}
