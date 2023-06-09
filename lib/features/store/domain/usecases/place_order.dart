// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';

import 'package:mealmate/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class PlaceOrderUseCase implements UseCase<NoResponse, PlaceOrderParams> {
  final StoreRepository repository;

  const PlaceOrderUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(PlaceOrderParams params) async {
    return repository.placeOrder(body: params.getBody());
  }
}

class PlaceOrderParams implements UseCaseParams {
  final List<OrderItemsModel> ingredients;
  const PlaceOrderParams({required this.ingredients});

  @override
  ParamsMap getParams() => {"ingredients": "$ingredients"};

  @override
  BodyMap getBody() =>
      {"ingredients": ingredients.map((e) => e.toMap()).toList()};
}

class OrderItemsModel {
  int unitId;
  int quantity;
  String ingredientId;
  OrderItemsModel({
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

  factory OrderItemsModel.fromMap(Map<String, dynamic> map) {
    return OrderItemsModel(
      unitId: map['unitId'] as int,
      quantity: map['quantity'] as int,
      ingredientId: map['ingredientId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItemsModel.fromJson(String source) =>
      OrderItemsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
