import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class AddToWishlistUseCase implements UseCase<NoResponse, AddToWishlistParams> {
  final StoreRepository repository;

  const AddToWishlistUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(AddToWishlistParams params) async {
    return repository.addToWishlist(
      body: params.getBody(),
      params: params.getParams(),
    );
  }
}

class AddToWishlistParams implements UseCaseParams {
  final String ingredientId;
  const AddToWishlistParams({required this.ingredientId});

  @override
  ParamsMap getParams() => {};

  @override
  BodyMap getBody() => {'ingredient_id': ingredientId};
}
