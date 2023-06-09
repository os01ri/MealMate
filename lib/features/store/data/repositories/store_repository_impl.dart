import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/core/unified_api/handling_exception_manager.dart';
import 'package:mealmate/features/store/data/datasources/remote_store_datasource.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/index_wishlist_items_response_model.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';
import 'package:mealmate/features/store/domain/repositories/store_repository.dart';

class StoreRepositoryImpl with HandlingExceptionManager implements StoreRepository {
  final _datasource = RemoteStoreDatasource();

  @override
  Future<Either<Failure, IndexIngredientsResponseModel>> indexIngredients({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexIngredients(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, ShowIngredientResponseModel>> showIngredient({required String id}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.showIngredient(id: id);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, IndexWishlistItemsResponseModel>> indexWishlist({ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.indexWishlist(params: params);
        return Right(result);
      },
    );
  }

  @override
  Future<Either<Failure, NoResponse>> addToWishlist({required BodyMap body, ParamsMap params}) {
    return wrapHandling(
      tryCall: () async {
        final result = await _datasource.addToWishlist(body: body, params: params);
        return Right(result);
      },
    );
  }
  
  @override
  Future<Either<Failure, NoResponse>> placeOrder({required BodyMap body}) {
    return wrapHandling(tryCall: () async {
      final result = await _datasource.placeOrder(body: body);
      return Right(result);
    });
  }
}
