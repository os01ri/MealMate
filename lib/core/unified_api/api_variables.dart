import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  static const _scheme = 'http';
  static const _host = 'food.programmer23.store';

  static Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: '/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  ///Auth
  static Uri _auth({required String path}) {
    return _mainUri(path: 'user/$path');
  }

  static Uri register() {
    return _auth(path: 'register');
  }
  static Uri login() {
    return _auth(path: 'login ');
  }

  static Uri uploadMedia() => _mainUri(path: 'mediaUpload');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  static Uri _mobileUri({required String path, Map<String, dynamic>? queryParameters}) => _mainUri(
        path: path,
        queryParameters: queryParameters,
      );

  static Uri indexRecipes({Map<String, dynamic>? queryParameters}) =>
      _mobileUri(path: 'recipe/index', queryParameters: queryParameters);

  static Uri indexIngredients({Map<String, dynamic>? queryParameters}) =>
      _mobileUri(path: 'ingredient', queryParameters: queryParameters);
}
