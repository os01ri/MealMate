import 'package:dartz/dartz.dart';
import 'package:mealmate/features/recipe/data/models/recipe_category_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/recipe_repository.dart';

class IndexRecipeTypesUseCase
    implements UseCase<RecipeCategoryResponseModel, NoParams> {
  final RecipeRepository repository;

  const IndexRecipeTypesUseCase({required this.repository});

  @override
  Future<Either<Failure, RecipeCategoryResponseModel>> call(
      NoParams noParams) async {
    return repository.indexRecipeTypes();
  }
}
