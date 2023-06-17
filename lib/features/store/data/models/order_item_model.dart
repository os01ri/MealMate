import 'dart:convert';

class OrderItemModel {
  final int unitId;
  final int quantity;
  final int ingredientId;

  const OrderItemModel({
    required this.unitId,
    required this.ingredientId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unit_id': unitId,
      'quantity': quantity,
      'ingredient_id': ingredientId,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      unitId: map['unit_id'] as int,
      quantity: map['quantity'] as int,
      ingredientId: map['ingredient_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) => OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
