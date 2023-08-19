import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/favorite_recipes_repository.dart';

class AddFavoriteRecipeUsecase implements UseCase<NoResponse, AddFavoriteRecipeParams> {
  final FavoriteRecipesRepository repository;

  const AddFavoriteRecipeUsecase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(AddFavoriteRecipeParams params) async {
    return repository.addFavoriteRecipe(body: params.getBody());
  }
}

class AddFavoriteRecipeParams implements UseCaseParams {
  final int id;

  const AddFavoriteRecipeParams({required this.id});

  @override
  BodyMap getBody() => {'recipe_id': id};

  @override
  ParamsMap? getParams() => {};
}
