import 'index_ingredients_response_model.dart';

class CartItemModel {
  IngredientModel? model;
  int quantity;

  CartItemModel({
    this.model,
    this.quantity = 1,
  });

  CartItemModel copyWith({
    IngredientModel? model,
    int? quantity,
  }) {
    return CartItemModel(
      model: model ?? this.model,
      quantity: quantity ?? this.quantity,
    );
  }
}
