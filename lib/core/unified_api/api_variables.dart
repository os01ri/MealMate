import 'dart:developer';

import '../extensions/colorful_logging_extension.dart';
import '../helper/type_defs.dart';

class ApiVariables {
  ApiVariables._();

  /////////////
  ///General///
  /////////////
  static const _scheme = 'http';
  static const _host = 'food.programmer23.store';

  static Uri _mainUri({
    required String path,
    ParamsMap params,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      queryParameters: params,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  static Uri _mobileUri({required String path, ParamsMap params}) => _mainUri(path: 'user/$path', params: params);

  //notification
  static Uri indexNotifications() => _mainUri(path: '/notification/get');

  ///user
  static Uri getUserInfo() => _mobileUri(path: 'showuserinfo');
  static Uri updateUserInfo() => _mobileUri(path: 'updateprofile');
  static Uri showProfileInfo(int id) => _mobileUri(path: '$id/showuser');

  ///Auth
  static Uri _auth({required String path}) => _mobileUri(path: 'auth/$path');

  static Uri register() => _auth(path: 'register');

  static Uri login() => _auth(path: 'login');

  static Uri verifyAccount() => _auth(path: 'verifyaccount');

  static Uri sendResetPasswordOTP() => _mobileUri(path: 'password/sendemail');

  static Uri checkPasswordCode() => _mobileUri(path: 'password/checkCode');

  static Uri changePassword() => _mobileUri(path: 'password/changePassword');
  static Uri refreshToken() => _auth(path: 'refreshtoken');
  static Uri placeOrder() => _mobileUri(path: "order/store");

  /////
  static Uri indexRestrictions() => _mobileUri(path: 'unlikeingredient/index');
  static Uri showRestrictions({required int id}) => _mobileUri(path: 'unlikeingredient/$id/show');
  static Uri addRestriction() => _mobileUri(path: 'unlikeingredient/store');
  static Uri deleteRestriction({required int id}) => _mobileUri(path: 'unlikeingredient/$id/destroy');

  ///grocery
  static Uri groceryIndex() => _mobileUri(path: 'grocery/index');

  static Uri groceryStore() => _mobileUri(path: 'grocery/store');

  static Uri groceryUpdate(ParamsMap params) => _mobileUri(path: 'grocery/update', params: params);

  static Uri groceryDelete(int id) => _mobileUri(path: 'grocery/$id/destroy');

  ///Media
  static Uri uploadMedia() => _mainUri(path: 'addimage');

//////////////////////
////////Follower////////
//////////////////////

  static Uri indexFollowers() => _mobileUri(path: 'follow/indexfollowby');
  static Uri indexFollowings() => _mobileUri(path: 'follow/indexfollower');
  static Uri follow() => _mobileUri(path: 'follow/store');
  static Uri unFollow() => _mobileUri(path: 'follow/unfollow');

  //////////////////////
  ////////Recipe////////
  //////////////////////
  static Uri indexRecipesForUser({ParamsMap params}) => _mobileUri(path: 'recipe/getUserRecipe', params: params);
  static Uri indexRecipesByFollowings({ParamsMap params}) => _mobileUri(path: 'recipe/indexbyfollow', params: params);
  static Uri indexRecipesTrending({ParamsMap params}) => _mobileUri(path: 'recipe/indextrending', params: params);
  static Uri indexRecipesMostRated({ParamsMap params}) => _mobileUri(path: 'recipe/indexmostrated', params: params);
  static Uri indexRecipes({ParamsMap params}) => _mobileUri(path: 'recipe/index', params: params);
  static Uri indexUserRecipe({ParamsMap? params}) => _mobileUri(path: 'recipe/getUserRecipe', params: params);
  static Uri showRecipe(int id) => _mobileUri(path: 'recipe/$id/show');

  static Uri addRecipe() => _mobileUri(path: 'recipe/store');
  static Uri indexTypes() => _mobileUri(path: 'type/index');
  static Uri indexCategories() => _mobileUri(path: 'category/index');

  static Uri cookRecipe({ParamsMap params}) => _mobileUri(path: 'recipe/cook', params: params);

  static Uri rateRecipe({ParamsMap params}) => _mobileUri(path: 'recipe/storerate', params: params);

  /////ingredient////
  static Uri indexIngredientsCategories({ParamsMap params}) =>
      _mobileUri(path: 'categoryingredient/index', params: params);

  static Uri indexIngredients({ParamsMap params}) => _mobileUri(path: 'ingredient/index', params: params);

  static Uri showIngredients({required int id, ParamsMap queryParameters}) => _mobileUri(path: 'ingredient/$id/show');

  static Uri indexWishlist({ParamsMap params}) => _mobileUri(path: 'wishlist/index');

  static Uri addToWishlist({ParamsMap params}) => _mobileUri(path: 'wishlist/store');

  static Uri removeFromWishlist({required int id, ParamsMap params}) => _mobileUri(path: 'wishlist/$id/destroy');

  /////favorite recipes////
  static Uri indexFavoriteRecipes() => _mobileUri(path: 'likerecipe/index');
  static Uri addFavoriteRecipe() => _mobileUri(path: 'likerecipe/store');
  static Uri removeFavoriteRecipe({required int id}) => _mobileUri(path: 'likerecipe/$id/destroy');
}
