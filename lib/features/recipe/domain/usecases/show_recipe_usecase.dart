import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/show_recipe_response_model.dart';
import '../repositories/recipe_repository.dart';

class ShowRecipeUseCase implements UseCase<ShowRecipeResponseModel, int> {
  final RecipeRepository repository;

  const ShowRecipeUseCase({required this.repository});

  @override
  Future<Either<Failure, ShowRecipeResponseModel>> call(int id) async {
    return repository.showRecipe(id: id);
  }
}
