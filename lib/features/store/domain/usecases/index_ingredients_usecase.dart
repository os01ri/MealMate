import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_ingredients_response_model.dart';
import '../repositories/store_repository.dart';

class IndexIngredientsUseCase implements UseCase<IndexIngredientsResponseModel, IndexIngredientsParams> {
  final StoreRepository repository;

  IndexIngredientsUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexIngredientsResponseModel>> call(IndexIngredientsParams params) async {
    return repository.indexIngredients(params: params.getParams());
  }
}

class IndexIngredientsParams implements UseCaseParams {
  final int? perPage;
  final int? page;
  final String? name;
  final int? categoryId;

  const IndexIngredientsParams({
    this.perPage,
    this.page,
    this.name,
    this.categoryId,
  });

  @override
  ParamsMap getParams() => {
        if (page != null) "page": page.toString(),
        if (perPage != null) "perPage": perPage.toString(),
        if (categoryId != null) "category": categoryId.toString(),
        if (name != null) "name": name,
      };

  @override
  BodyMap getBody() => {};
}
