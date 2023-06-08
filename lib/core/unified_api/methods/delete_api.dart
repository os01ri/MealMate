import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mealmate/core/extensions/colorful_consule_string_extinsion.dart';
import 'package:mealmate/core/helper/type_defs.dart';

import '../../helper/helper.dart';
import '../handling_exception_request.dart';

class DeleteApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  DeleteApi({
    required this.uri,
    required this.fromJson,
  });
  Future<T> callRequest() async {
    String? token = Helper.userToken;
    String fcmToken = await Helper.getFCMToken();
    bool isAuth = await Helper.isAuth();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'fcm_token': fcmToken,
        if (isAuth) 'Authorization': 'Bearer $token',
      };
      var request = http.Request('DELETE', uri);
      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse = await request.send().timeout(const Duration(seconds: 20));
      http.Response response = await http.Response.fromStream(streamedResponse);
      log(response.body.logGreen);
      if (response.statusCode == 200) {
        return fromJson(response.body);
      } else {
        Exception exception = getException(response: response);
        throw exception;
      }
    } on HttpException {
      log(
        'http exception'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } on FormatException {
      log(
        'something went wrong in parsing the uri'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } on SocketException {
      log(
        'socket exception'.logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    } catch (e) {
      log(
        e.toString().logRed,
        name: 'RequestManager get function',
      );
      rethrow;
    }
  }
}
