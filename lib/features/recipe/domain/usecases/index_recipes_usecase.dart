import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../repositories/recipe_repository.dart';

class IndexRecipesUseCase implements UseCase<IndexRecipesResponseModel, IndexRecipesParams> {
  final RecipeRepository repository;

  const IndexRecipesUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(IndexRecipesParams params) async {
    return repository.indexRecipes(params: params.getParams());
  }
}

class IndexRecipesParams implements UseCaseParams {
  final int? perPage;
  final int? page;

  const IndexRecipesParams({
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
