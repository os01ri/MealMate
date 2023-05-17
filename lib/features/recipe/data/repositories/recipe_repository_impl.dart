import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/recipe/data/datasources/remote_recipe_datasource.dart';
import 'package:mealmate/features/recipe/data/models/recipe_model.dart';
import 'package:mealmate/features/recipe/domain/entities/recipe.dart';
import 'package:mealmate/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl with HandlingExceptionManager implements RecipeRepository {
  final _datasource = RemoteRecipeDatasource();

  @override
  Future<Either<Failure, List<RecipeModel>>> indexRecipes({Map<String, dynamic>? params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexRecipes(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, Recipe>> showRecipe({required int id}) {
    // TODO: implement showRecipe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> addRecipe({required Recipe recipe}) {
    // TODO: implement addRecipe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteRecipe({required int id}) {
    // TODO: implement deleteRecipe
    throw UnimplementedError();
  }
}
