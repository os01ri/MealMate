import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_categories_response_model.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class IndexIngredientsCategoriesUseCase
    implements UseCase<IndexIngredientCategoriesResponseModel, IndexIngredientsCategoriesParams> {
  final StoreRepository repository;

  IndexIngredientsCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexIngredientCategoriesResponseModel>> call(IndexIngredientsCategoriesParams params) async {
    return repository.indexIngredientsCategories(params: params.getParams());
  }
}

class IndexIngredientsCategoriesParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  const IndexIngredientsCategoriesParams({
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
