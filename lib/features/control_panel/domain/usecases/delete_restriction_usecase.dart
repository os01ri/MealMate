import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/control_panel_repository.dart';

class DeleteRestrictionUsecase implements UseCase<NoResponse, DeleteRestrictionParams> {
  final ControlPanelRepository repository;

  const DeleteRestrictionUsecase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(DeleteRestrictionParams params) async {
    return repository.deleteRestriction(id: params.id);
  }
}

class DeleteRestrictionParams implements UseCaseParams {
  final int id;

  DeleteRestrictionParams({required this.id});

  @override
  BodyMap getBody() => {};

  @override
  ParamsMap? getParams() => {};
}
