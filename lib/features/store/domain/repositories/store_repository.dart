import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IndexIngredientsResponseModel>> indexIngredients({Map<String, dynamic> params});

  Future<Either<Failure, ShowIngredientResponseModel>> showIngredient({required String id});
}
