// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/data/models/order_item_model.dart';
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
  final List<OrderItemModel> ingredients;
  const PlaceOrderParams({required this.ingredients});

  @override
  ParamsMap getParams() => {"ingredients": "$ingredients"};

  @override
  BodyMap getBody() => {
        "ingredients": ingredients.map((e) => e.toMap()).toList(),
      };
}
