import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/helper/type_defs.dart';
import '../../../../core/models/no_response_model.dart';
import '../../data/models/index_ingredients_categories_response_model.dart';
import '../../data/models/index_ingredients_response_model.dart';
import '../../data/models/index_wishlist_items_response_model.dart';
import '../../data/models/show_ingredient_response_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IndexIngredientCategoriesResponseModel>> indexIngredientsCategories({ParamsMap params});

  Future<Either<Failure, IndexIngredientsResponseModel>> indexIngredients({ParamsMap params});

  Future<Either<Failure, ShowIngredientResponseModel>> showIngredient({required int id});

  Future<Either<Failure, IndexWishlistItemsResponseModel>> indexWishlist({ParamsMap params});

  Future<Either<Failure, NoResponse>> addToWishlist({required BodyMap body, ParamsMap params});

  Future<Either<Failure, NoResponse>> removeFromWishlist({required int id, ParamsMap params});

  Future<Either<Failure, NoResponse>> placeOrder({required BodyMap body});
}
