import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repositories/favorite_recipes_repository.dart';
import '../datasources/favorite_recipes_datasource.dart';
import '../models/favorite_recipes_response_model.dart';

class FavoriteRecipesRepositoryImpl with HandlingExceptionManager implements FavoriteRecipesRepository {
  @override
  Future<Either<Failure, FavoriteRecipesResponseModel>> indexFavoriteRecipes() {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteFavoriteRecipesDataSource.indexFavoriteRecipes();
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> addFavoriteRecipe({required BodyMap body}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteFavoriteRecipesDataSource.addFavoriteRecipe(body: body);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> deleteFavoriteRecipe({required int id}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteFavoriteRecipesDataSource.deleteFavoriteRecipe(id: id);
        return Right(result);
      },
    );
  }
}
