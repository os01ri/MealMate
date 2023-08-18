import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/recipe/data/models/index_recipes_response_model.dart';

import '../../domain/repository/control_panel_repository.dart';

class ControlPanelRepoImpl
    with HandlingExceptionManager
    implements ControlPanelRepository {
  @override
  Future<Either<Failure, IndexRecipesResponseModel>> indexMyRecipes() {
    throw UnimplementedError();
  }
}
