import 'package:bloc/bloc.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState());
  addOrUpdateProduct({required IngredientModel ingredient}) {
    emit(state.copyWith(cartItems: List.of(state.cartItems)..add(ingredient)));
  }

  deleteProduct({required IngredientModel ingredient}) {}

  // getCartLocal(){}
}

class CartItem {
  final String name;
  final String photoUrl;
  final double price;
  final String priceBy;
  int quantity;

  CartItem({
    required this.name,
    required this.photoUrl,
    required this.price,
    required this.priceBy,
    this.quantity = 1,
  });

  CartItem copyWith({
    String? name,
    String? photoUrl,
    String? priceBy,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      priceBy: priceBy ?? this.priceBy,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}
