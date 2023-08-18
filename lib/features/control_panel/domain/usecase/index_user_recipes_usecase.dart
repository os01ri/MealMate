import 'package:dartz/dartz.dart';
import 'package:mealmate/features/control_panel/domain/repository/control_panel_repository.dart';
import 'package:mealmate/features/recipe/data/models/index_recipes_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class IndexUserRecipesUsecase
    implements UseCase<IndexRecipesResponseModel, NoParams> {
  final ControlPanelRepository repository;

  const IndexUserRecipesUsecase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(NoParams body) async {
    return repository.indexMyRecipes();
  }
}
