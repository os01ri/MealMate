import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/store_repository.dart';

class RemoveFromWishlistUseCase implements UseCase<NoResponse, RemoveFromWishlistParams> {
  final StoreRepository repository;

  const RemoveFromWishlistUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(RemoveFromWishlistParams params) async {
    return repository.removeFromWishlist(id: params.ingredientId);
  }
}

class RemoveFromWishlistParams implements UseCaseParams {
  final String ingredientId;
  const RemoveFromWishlistParams({required this.ingredientId});

  @override
  ParamsMap getParams() => {};

  @override
  BodyMap getBody() => {};
}
