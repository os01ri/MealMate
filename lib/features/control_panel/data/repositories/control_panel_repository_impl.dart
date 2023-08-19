import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
import '../../domain/repositories/control_panel_repository.dart';

class ControlPanelRepositoryImpl with HandlingExceptionManager implements ControlPanelRepository {
  @override
  Future<Either<Failure, IndexRecipesResponseModel>> indexUserRecipes() {
    throw UnimplementedError();
  }
}
