import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/control_panel_repository.dart';

class AddRestrictionUsecase implements UseCase<NoResponse, AddRestrictionParams> {
  final ControlPanelRepository repository;

  const AddRestrictionUsecase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(AddRestrictionParams params) async {
    return repository.addRestriction(body: params.getBody());
  }
}

class AddRestrictionParams implements UseCaseParams {
  final int id;

  AddRestrictionParams({required this.id});

  @override
  BodyMap getBody() => {"ingredient_id": id};

  @override
  ParamsMap? getParams() => {};
}
