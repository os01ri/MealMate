import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/remote_store_datasource.dart';
import '../models/index_ingredients_categories_response_model.dart';
import '../models/index_ingredients_response_model.dart';
import '../models/index_wishlist_items_response_model.dart';
import '../models/show_ingredient_response_model.dart';

class StoreRepositoryImpl with HandlingExceptionManager implements StoreRepository {
  @override
  Future<Either<Failure, IndexIngredientCategoriesResponseModel>> indexIngredientsCategories({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.indexIngredientsCategories(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, IndexIngredientsResponseModel>> indexIngredients({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.indexIngredients(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, ShowIngredientResponseModel>> showIngredient({required int id}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.showIngredient(id: id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, IndexWishlistItemsResponseModel>> indexWishlist({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.indexWishlist(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> addToWishlist({required BodyMap body, ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.addToWishlist(body: body, params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> removeFromWishlist({required int id, ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await RemoteStoreDatasource.removeFromWishlist(id: id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> placeOrder({required BodyMap body}) {
    return wrapHandling(tryCall: () async {
      final result = await RemoteStoreDatasource.placeOrder(body: body);
      return Right(result);
    });
  }
}
