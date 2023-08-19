import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/favorite_recipes_response_model.dart';
import '../repositories/favorite_recipes_repository.dart';

class IndexFavoriteRecipesUsecase implements UseCase<FavoriteRecipesResponseModel, NoParams> {
  final FavoriteRecipesRepository repository;

  const IndexFavoriteRecipesUsecase({required this.repository});

  @override
  Future<Either<Failure, FavoriteRecipesResponseModel>> call(NoParams _) async {
    return repository.indexFavoriteRecipes();
  }
}
