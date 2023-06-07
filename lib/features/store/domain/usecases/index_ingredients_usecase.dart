import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

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

  const IndexIngredientsParams({
    this.perPage,
    this.page,
  });

  @override
  ParamsMap getParams() 
    => {
      if (page != null) "page": page.toString(),
      if (perPage != null) "perPage": perPage.toString(),
    };
  

  @override
  BodyMap getBody() => {};
}
