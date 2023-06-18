import 'package:dartz/dartz.dart';
import '../repositories/grocery_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/index_grocery_response_model.dart';

class IndexGroceryUseCase
    implements UseCase<IndexGroceryResponseModel, NoParams> {
  final GroceryRepostiory repository;

  IndexGroceryUseCase({required this.repository});

  @override
  Future<Either<Failure, IndexGroceryResponseModel>> call(
      NoParams params) async {
    return repository.indexGroceryItems();
  }
}
