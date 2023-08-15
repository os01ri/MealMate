import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/recipe_category_model.dart';
import '../repositories/recipe_repository.dart';

class IndexRecipeCategoriesUseCase implements UseCase<RecipeCategoryResponseModel, NoParams> {
  final RecipeRepository repository;

  const IndexRecipeCategoriesUseCase({required this.repository});

  @override
  Future<Either<Failure, RecipeCategoryResponseModel>> call(NoParams noParams) async {
    return repository.indexRecipeCategories();
  }
}
