import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';
import 'package:mealmate/features/recipe/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<RecipeModel>>> indexRecipes({ParamsMap params});

  Future<Either<Failure, Recipe>> showRecipe({required int id});

  Future<Either<Failure, Unit>> addRecipe({required Recipe recipe});

  Future<Either<Failure, Unit>> deleteRecipe({required int id});
}
