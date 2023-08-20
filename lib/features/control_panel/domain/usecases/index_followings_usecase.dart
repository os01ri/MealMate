import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/follows_response_model.dart';
import '../repositories/control_panel_repository.dart';

class IndexFollowingsUsecase implements UseCase<FollowsResponseModel, NoParams> {
  final ControlPanelRepository repository;

  const IndexFollowingsUsecase({required this.repository});

  @override
  Future<Either<Failure, FollowsResponseModel>> call(NoParams _) async {
    return repository.indexFollowings();
  }
}
