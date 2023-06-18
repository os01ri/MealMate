import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/recipe_model.dart';
import '../repositories/recipe_repository.dart';

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
