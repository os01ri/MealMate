import 'dart:convert';

class OrderItemModel {
  final int unitId;
  final int quantity;
  final String ingredientId;

  const OrderItemModel({
    required this.unitId,
    required this.ingredientId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitId': unitId,
      'quantity': quantity,
      'ingredientId': ingredientId,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      unitId: map['unitId'] as int,
      quantity: map['quantity'] as int,
      ingredientId: map['ingredientId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemModel.fromJson(String source) => OrderItemModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
