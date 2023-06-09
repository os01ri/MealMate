import 'package:dartz/dartz.dart';
import 'package:mealmate/core/error/failures.dart';
import 'package:mealmate/core/helper/type_defs.dart';
import 'package:mealmate/core/models/no_response_model.dart';
import 'package:mealmate/features/store/data/models/index_ingredients_response_model.dart';
import 'package:mealmate/features/store/data/models/index_wishlist_items_response_model.dart';
import 'package:mealmate/features/store/data/models/show_ingredient_response_model.dart';

abstract class StoreRepository {
  Future<Either<Failure, IndexIngredientsResponseModel>> indexIngredients({ParamsMap params});

  Future<Either<Failure, ShowIngredientResponseModel>> showIngredient({required String id});

  Future<Either<Failure, IndexWishlistItemsResponseModel>> indexWishlist({ParamsMap params});

  Future<Either<Failure, NoResponse>> addToWishlist({required BodyMap body, ParamsMap params});

  Future<Either<Failure, NoResponse>> removeFromWishlist({required String id, ParamsMap params});

  Future<Either<Failure, NoResponse>> placeOrder({required BodyMap body});
}
