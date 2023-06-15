import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mealmate/core/extensions/colorful_logging_extension.dart';
import 'package:mealmate/core/helper/type_defs.dart';

import '../../helper/helper.dart';
import '../handling_exception_request.dart';

class PutApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final Map body;
  final FromJson fromJson;
  final bool isLogin;
  final Duration timeout;

  const PutApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.isLogin = false,
    this.timeout = const Duration(seconds: 20),
  });

  Future<T> callRequest() async {
    String? token = Helper.userToken;
    // String fcmToken = await HelperFunctions.getFCMToken();
    bool isAuth = await Helper.isAuth();

    log('the token in the request header is $token',
        name: 'request manager ==> post function ');
    try {
      var headers = {
        'Content-Type': 'application/json',
        // 'fcm_token': fcmToken,
        'Accept': 'application/json',
        if (isAuth) 'Authorization': 'Bearer $token',
      };

      var request = http.Request('Put', uri);
      request.body = jsonEncode(body);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse =
          await request.send().timeout(timeout);
      log(request.body.logGreen, name: "request body");
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body.logGreen);
      log(response.statusCode.toString().logGreen);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception'.logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString().logRed,
        name: 'RequestManager post function',
      );
      rethrow;
    }
  }
}
