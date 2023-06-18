import 'package:dartz/dartz.dart';
import '../../../../core/models/no_response_model.dart';
import '../repositories/grocery_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class StoreItemInGroceryUseCase implements UseCase<NoResponse, NoParams> {
  final GroceryRepostiory repository;

  StoreItemInGroceryUseCase({required this.repository});

  @override
  Future<Either<Failure, NoResponse>> call(NoParams params) async {
    return repository.deleteGroceryItem(0);
  }
}
