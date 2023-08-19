import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/features/profile/data/model/show_user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ShowUserModelResponse>> showUserInfo(int id);
}
