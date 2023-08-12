import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/recipe_repository.dart';

class CookRecipeUseCase implements UseCase<NoResponse, CookRecipeParams> {
  final RecipeRepository repository;

  const CookRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(CookRecipeParams params) async {
    return repository.cookRecipe(body: params.getBody());
  }
}

class CookRecipeParams implements UseCaseParams {
  final int id;

  const CookRecipeParams({required this.id});

  @override
  BodyMap getBody() => {"recipe_id": id};

  @override
  ParamsMap getParams() => {};
}
