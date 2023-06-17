import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_wishlist_items_response_model.dart';
import '../repositories/store_repository.dart';

class IndexWishlistUseCase implements UseCase<IndexWishlistItemsResponseModel, IndexWishlistParams> {
  final StoreRepository repository;

  const IndexWishlistUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexWishlistItemsResponseModel>> call(IndexWishlistParams params) async {
    return repository.indexWishlist(params: params.getParams());
  }
}

class IndexWishlistParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  const IndexWishlistParams({
    this.perPage,
    this.page,
  });

  @override
  ParamsMap getParams() => {
        if (page != null) "page": page.toString(),
        if (perPage != null) "perPage": perPage.toString(),
      };

  @override
  BodyMap getBody() => {};
}
