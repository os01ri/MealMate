import 'dart:developer';

import 'package:mealmate/core/extensions/colorful_consule_string_extinsion.dart';
import 'package:mealmate/core/helper/type_defs.dart';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  static const _scheme = 'http';
  static const _host = 'food.programmer23.store';

  static Uri _mainUri({
    required String path,
    ParamsMap queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: path,
      queryParameters: queryParameters,
    );
    log(uri.toString().logMagenta);
    return uri;
  }

  static Uri _mobileUri({required String path, ParamsMap queryParameters}) => _mainUri(
        path: 'user/$path',
        queryParameters: queryParameters,
      );

  ///Auth
  static Uri _auth({required String path}) {
    return _mobileUri(path: 'auth/$path');
  }

  static Uri register() {
    return _auth(path: 'register');
  }

  static Uri login() {
    return _auth(path: 'login');
  }

  static Uri sendResetPasswordOTP() {
    return _mobileUri(path: 'password/sendemail');
  }

  static Uri checkPasswordCode() {
    return _mobileUri(path: 'password/chcekCode');
  }

  static Uri placeOrder() {
    return _mobileUri(path: "order/store");
  }

  ///Media
  static Uri uploadMedia() => _mainUri(path: 'mediaUpload');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  static Uri indexRecipes({ParamsMap queryParameters}) =>
      _mobileUri(path: 'recipe/index', queryParameters: queryParameters);

  /////ingredient////
  static Uri indexIngredients({ParamsMap queryParameters}) =>
      _mobileUri(path: 'ingredient', queryParameters: queryParameters);

  static Uri showIngredients({required String id, ParamsMap queryParameters}) => _mobileUri(path: 'ingredient/$id');

  static Uri indexWishlist({ParamsMap queryParameters}) => _mobileUri(
        path: 'wishlist',
      );

  static Uri addToWishlist({ParamsMap queryParameters}) => _mobileUri(
        path: 'wishlist/addtowishlist',
      );
  static Uri removeFromWishlist({required String id, ParamsMap queryParameters}) => _mobileUri(
        path: 'wishlist/$id',
      );
}
