import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mealmate/core/extensions/colorful_consule_string_extinsion.dart';
import 'package:mealmate/core/helper/type_defs.dart';

import '../../helper/helper.dart';
import '../handling_exception_request.dart';

class GetApi<T> with HandlingExceptionRequest {
  final Uri uri;
  final FromJson fromJson;
  final Map? body;
  final bool getFCMToken;

  GetApi({
    required this.uri,
    required this.fromJson,
    this.body = const {},
    this.getFCMToken = false,
  });
  Future<T> callRequest() async {
    //TODO

    String? token = Helper.userToken;
    log(token.toString().logWhite, name: 'user token');
    // String fcmToken = await HelperFunctions.getFCMToken(getFCMToken: getFCMToken);
    // bool isAuth = await Helper.isAuth();
    String? deviceId = "";
    if (getFCMToken) {
      // deviceId = await HelperFunctions.getDeviceId(); TODO: uncomment
    }
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'fcm_token': fcmToken,
        'Authorization': 'Bearer $token',
        if (getFCMToken) "device_id": deviceId,
      };
      var request = http.Request('GET', uri);
      request.body = jsonEncode(body);
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
