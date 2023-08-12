import 'index_ingredients_response_model.dart';

class CartItemModel {
  IngredientModel? model;
  int quantity;
  int? unitId;

  CartItemModel({this.model, this.quantity = 1, this.unitId});

  CartItemModel copyWith({
    IngredientModel? model,
    int? quantity,
    int? unitId,
  }) {
    return CartItemModel(
      model: model ?? this.model,
      unitId: unitId ?? this.unitId,
      quantity: quantity ?? this.quantity,
    );
  }
}
