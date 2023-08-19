import 'package:dartz/dartz.dart';
import 'package:mealmate/core/helper/type_defs.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/no_response_model.dart';
import '../../data/models/favorite_recipes_response_model.dart';

abstract class FavoriteRecipesRepository {
  Future<Either<Failure, FavoriteRecipesResponseModel>> indexFavoriteRecipes();
  Future<Either<Failure, NoResponse>> addFavoriteRecipe({required BodyMap body});
  Future<Either<Failure, NoResponse>> deleteFavoriteRecipe({required int id});
}
