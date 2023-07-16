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

  ///Auth
  static Uri _auth({required String path}) => _mobileUri(path: 'auth/$path');

  static Uri register() => _auth(path: 'register');

  static Uri login() => _auth(path: 'login');

  static Uri verifyAccount() => _auth(path: 'verifyaccount');

  static Uri sendResetPasswordOTP() => _mobileUri(path: 'password/sendemail');

  static Uri checkPasswordCode() => _mobileUri(path: 'password/checkCode');

  static Uri changePassword() => _mobileUri(path: 'password/changePassword');

  static Uri placeOrder() => _mobileUri(path: "order/store");

  ///grocery
  static Uri groceryIndex() => _mobileUri(path: 'grocery/index');

  static Uri groceryStore() => _mobileUri(path: 'grocery/store');

  static Uri groceryUpdate(ParamsMap params) => _mobileUri(path: 'grocery/update', params: params);

  static Uri groceryDelete(int id) => _mobileUri(path: 'grocery/$id/destroy');

  ///Media
  static Uri uploadMedia() => _mainUri(path: 'addimage');

  //////////////////////
  ////////Recipe////////
  //////////////////////
  static Uri indexRecipes({ParamsMap params}) => _mobileUri(path: 'recipe/index', params: params);

  static Uri showRecipe(int id) => _mobileUri(path: 'recipe/$id/show');

  static Uri addRecipe() => _mobileUri(path: 'recipe/store');

  /////ingredient////
  static Uri indexIngredientsCategories({ParamsMap params}) =>
      _mobileUri(path: 'categoryingredient/index', params: params);

  static Uri indexIngredients({ParamsMap params}) => _mobileUri(path: 'ingredient/index', params: params);

  static Uri showIngredients({required int id, ParamsMap queryParameters}) => _mobileUri(path: 'ingredient/$id/show');

  static Uri indexWishlist({ParamsMap params}) => _mobileUri(path: 'wishlist/index');

  static Uri addToWishlist({ParamsMap params}) => _mobileUri(path: 'wishlist/store');

  static Uri removeFromWishlist({required int id, ParamsMap params}) => _mobileUri(path: 'wishlist/$id/destroy');
}
