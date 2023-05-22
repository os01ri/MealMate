import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/features/store/data/models/ingredient_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IngredientModelResponse>> indexIngredients({Map<String, dynamic> params});

  Future<Either<Failure, IngredientModel>> showIngredient({required int id});
}
