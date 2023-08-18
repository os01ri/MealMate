import 'package:dartz/dartz.dart';
import 'package:mealmate/core/models/no_response_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/recipe_repository.dart';

class UnFollowUserUseCase implements UseCase<NoResponse, int> {
  final RecipeRepository repository;

  const UnFollowUserUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(int userId) async {
    return repository.unFollowUser(body: {'user_id': userId});
  }
}
