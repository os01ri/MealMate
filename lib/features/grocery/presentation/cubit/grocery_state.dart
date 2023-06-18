// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'grocery_cubit.dart';

enum GroceryStatus { init, loading, success, failed }

enum DeleteGroceryItemStatus { init, loading, success, failed }

class GroceryState {
  const GroceryState(
      {this.cartItems = const [],
      this.status = GroceryStatus.init,
      this.deleteGroceryItemStatus = DeleteGroceryItemStatus.init});
  final List<IndexGroceryDataModel> cartItems;
  final GroceryStatus status;
  final DeleteGroceryItemStatus deleteGroceryItemStatus;

  GroceryState copyWith(
      {List<IndexGroceryDataModel>? cartItems,
      GroceryStatus? status,
      DeleteGroceryItemStatus? deleteGroceryItemStatus}) {
    return GroceryState(
        cartItems: cartItems ?? this.cartItems,
        status: status ?? this.status,
        deleteGroceryItemStatus:
            deleteGroceryItemStatus ?? this.deleteGroceryItemStatus);
  }
}
