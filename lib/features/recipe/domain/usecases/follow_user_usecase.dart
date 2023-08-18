import 'package:dartz/dartz.dart';
import 'package:mealmate/core/models/no_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/recipe_repository.dart';

class FollowUserUseCase implements UseCase<NoResponse, int> {
  final RecipeRepository repository;

  const FollowUserUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(int userId) async {
    return repository.followUser(body: {'user_id': userId});
  }
}
