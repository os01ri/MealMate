import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/favorite_recipes_repository.dart';

class RemoveFavoriteRecipeUsecase implements UseCase<NoResponse, RemoveFavoriteRecipeParams> {
  final FavoriteRecipesRepository repository;

  const RemoveFavoriteRecipeUsecase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(RemoveFavoriteRecipeParams params) async {
    return repository.deleteFavoriteRecipe(id: params.id);
  }
}

class RemoveFavoriteRecipeParams implements UseCaseParams {
  final int id;

  const RemoveFavoriteRecipeParams({required this.id});

  @override
  BodyMap getBody() => {};

  @override
  ParamsMap? getParams() => {};
}
