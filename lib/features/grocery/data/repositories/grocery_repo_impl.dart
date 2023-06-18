import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../datasources/grocery_datasource.dart';
import '../../domain/repositories/grocery_repository.dart';

class GroceryRepoImpl
    with HandlingExceptionManager
    implements GroceryRepostiory {
  GroceryDataSource dataSource = GroceryDataSource();
  @override
  indexGroceryItems() async {
    return wrapHandling(tryCall: () async {
      final result = await dataSource.indexGrocery();
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, NoResponse>> deleteGroceryItem(int id) {
    return wrapHandling(tryCall: () async {
      final result = await dataSource.deleteGroceryItem(id);
      return Right(result);
    });
  }
}
