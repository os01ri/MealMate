import 'package:dartz/dartz.dart';
import '../../../../core/models/no_response_model.dart';
import '../repositories/grocery_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class DeleteItemFromGroceryUseCase implements UseCase<NoResponse, int> {
  final GroceryRepostiory repository;

  DeleteItemFromGroceryUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(int id) async {
    return repository.deleteGroceryItem(id);
  }
}
