import 'package:dartz/dartz.dart';
import 'package:mealmate/features/profile/data/model/show_user_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/profile_repository.dart';

class ShowUserInfoUseCase implements UseCase<ShowUserModelResponse, int> {
  final ProfileRepository repository;

  ShowUserInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, ShowUserModelResponse>> call(int id) async {
    return repository.showUserInfo(id);
  }
}
