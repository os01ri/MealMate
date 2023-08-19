import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../recipe/data/models/index_recipes_response_model.dart';
import '../repositories/control_panel_repository.dart';

class IndexUserRecipesUsecase implements UseCase<IndexRecipesResponseModel, NoParams> {
  final ControlPanelRepository repository;

  const IndexUserRecipesUsecase({required this.repository});

  @override
  Future<Either<Failure, IndexRecipesResponseModel>> call(NoParams body) async {
    return repository.indexUserRecipes();
  }
}
