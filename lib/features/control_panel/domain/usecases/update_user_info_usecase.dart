import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/control_panel_repository.dart';

class UpdateUserInfoUseCase implements UseCase<NoResponse, UpdateUserInfoParams> {
  final ControlPanelRepository repository;

  const UpdateUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(UpdateUserInfoParams params) async {
    return repository.updateUserInfo(body: params.getBody());
  }
}

class UpdateUserInfoParams implements UseCaseParams {
  final String? image;
  final String name;
  final String username;
  final String city;

  UpdateUserInfoParams({
    this.image,
    required this.name,
    required this.username,
    required this.city,
  });

  @override
  BodyMap getBody() => {
        if (image != null) 'logo': image,
        'name': name,
        'username': username,
        'city': city,
      };

  @override
  ParamsMap? getParams() => {};
}
