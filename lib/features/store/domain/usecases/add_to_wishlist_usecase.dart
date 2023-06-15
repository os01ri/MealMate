import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/store_repository.dart';

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
