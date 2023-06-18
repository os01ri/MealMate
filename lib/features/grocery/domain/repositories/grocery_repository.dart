import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/no_response_model.dart';
import '../../data/models/index_grocery_response_model.dart';

abstract class GroceryRepostiory {
  Future<Either<Failure, IndexGroceryResponseModel>> indexGroceryItems();
  Future<Either<Failure, NoResponse>> deleteGroceryItem(int id);
}
