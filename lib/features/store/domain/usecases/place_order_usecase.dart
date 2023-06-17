import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/order_item_model.dart';
import '../repositories/store_repository.dart';

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
