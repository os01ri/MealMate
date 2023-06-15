import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../datasources/remote_recipe_datasource.dart';
import '../models/recipe_model.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl with HandlingExceptionManager implements RecipeRepository {
  final _datasource = RemoteRecipeDatasource();

  @override
  Future<Either<Failure, List<RecipeModel>>> indexRecipes({ParamsMap params}) {
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
