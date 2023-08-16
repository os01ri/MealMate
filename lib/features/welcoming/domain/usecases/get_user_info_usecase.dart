import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/user_info_response_model.dart';
import '../repositories/user_info_repository.dart';

class GetUserInfoUseCase implements UseCase<UserInfoResponseModel, NoParams> {
  final UserInfoRepository repository;

  const GetUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, UserInfoResponseModel>> call(NoParams _) async {
    return repository.getUserInfo();
  }
}
