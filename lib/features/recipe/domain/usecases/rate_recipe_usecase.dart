import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/recipe_repository.dart';

class RateRecipeUseCase implements UseCase<NoResponse, RateRecipeParams> {
  final RecipeRepository repository;

  const RateRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(RateRecipeParams params) async {
    return repository.rateRecipe(body: params.getBody());
  }
}

class RateRecipeParams implements UseCaseParams {
  final int id;
  final int rate;

  const RateRecipeParams({
    required this.id,
    required this.rate,
  });

  @override
  ParamsMap getParams() => {};

  @override
  BodyMap getBody() => {
        "id": id,
        "rate": rate,
      };
}
