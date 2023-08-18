import 'package:dartz/dartz.dart';
import 'package:mealmate/features/recipe/data/models/index_recipes_response_model.dart';

import '../../../../core/error/failures.dart';

abstract class ControlPanelRepository {
  Future<Either<Failure, IndexRecipesResponseModel>> indexMyRecipes();
}
