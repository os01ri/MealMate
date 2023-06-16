import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/usecase/usecase.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';
import 'package:mealmate/features/recipe/domain/repositories/recipe_repository.dart';

class IndexRecipesUseCase implements UseCase<List<RecipeModel>, IndexRecipesParams> {
  final RecipeRepository recipeRepository;

  IndexRecipesUseCase({required this.recipeRepository});

  @override
  Future<Either<Failure, List<RecipeModel>>> call(IndexRecipesParams params) async {
    return recipeRepository.indexRecipes(params: params.getParams());
  }
}

class IndexRecipesParams implements UseCaseParams {
  final int id;
  final int? perPage;
  final int? page;

  IndexRecipesParams({
    required this.id,
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
