import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../repositories/recipe_repository.dart';
import 'index_recipes_usecase.dart';

class IndexRecipesByFollowingsUseCase implements UseCase<IndexRecipesResponseModel, IndexRecipesParams> {
  final RecipeRepository repository;

  const IndexRecipesByFollowingsUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(IndexRecipesParams params) async {
    return repository.indexRecipesByFollowings(params: params.getParams());
  }
}
