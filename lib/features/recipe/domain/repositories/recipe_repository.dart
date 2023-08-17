import 'package:dartz/dartz.dart';
import 'package:mealmate/features/recipe/data/models/recipe_category_model.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../data/models/index_recipes_response_model.dart';
import '../../data/models/show_recipe_response_model.dart';

abstract class RecipeRepository {
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipes({ParamsMap params});
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipesForUser({ParamsMap params});
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipesTrending({ParamsMap params});
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipesMostOrdered({ParamsMap params});
  Future<Either<Failure, IndexRecipesResponseModel>> indexRecipesByFollowings({ParamsMap params});
  Future<Either<Failure, RecipeCategoryResponseModel>> indexRecipeCategories({ParamsMap params});
  Future<Either<Failure, RecipeCategoryResponseModel>> indexRecipeTypes({ParamsMap params});

  Future<Either<Failure, ShowRecipeResponseModel>> showRecipe({required int id});

  Future<Either<Failure, NoResponse>> addRecipe({required BodyMap recipe});

  Future<Either<Failure, NoResponse>> cookRecipe({required BodyMap body});

  Future<Either<Failure, NoResponse>> rateRecipe({required BodyMap body});
}
