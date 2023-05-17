import 'dart:developer';

class ApiVariables {
  /////////////
  ///General///
  /////////////
  static const _scheme = 'https';
  static const _host = '192.168.243.1';

  static Uri _mainUri({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    final uri = Uri(
      scheme: _scheme,
      host: _host,
      path: 'api/$path',
      queryParameters: queryParameters,
    );
    log(uri.toString());
    return uri;
  }

  static Uri uploadMedia() => _mainUri(path: 'mediaUpload');
  // Uri uploadVideo() => _mainUri(path: "videoUpload");
  // Uri uploadGif() => _mainUri(path: "GIFUpload");

  static Uri _mobileUri({required String path, Map<String, dynamic>? queryParameters}) => _mainUri(
        path: 'mobile/$path',
        queryParameters: queryParameters,
      );

  static Uri indexRecipes({Map<String, dynamic>? queryParameters}) =>
      _mobileUri(path: 'recipe/index', queryParameters: queryParameters);
}
