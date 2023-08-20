import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/restrictions_response_model.dart';
import '../repositories/control_panel_repository.dart';

class IndexRestrictionsUsecase implements UseCase<RestrictionsResponseModel, NoParams> {
  final ControlPanelRepository repository;

  const IndexRestrictionsUsecase({required this.repository});

  @override
  Future<Either<Failure, RestrictionsResponseModel>> call(NoParams _) async {
    return repository.indexRestrictions();
  }
}
