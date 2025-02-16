import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../extensions/colorful_logging_extension.dart';
import '../../helper/type_defs.dart';
import '../handling_exception_request.dart';

class MultiPostApi with HandlingExceptionRequest {
  final Uri uri;
  final Map<String, String> body;
  final FromJson fromJson;
  final Duration timeout;

  const MultiPostApi({
    required this.uri,
    required this.body,
    required this.fromJson,
    this.timeout = const Duration(seconds: 20),
  });

  Future<dynamic> call() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      http.MultipartRequest request = http.MultipartRequest('POST', uri);
      for (var item in body.entries) {
        request.files.add(await http.MultipartFile.fromPath(item.key, item.value));
      }

      request.headers.addAll(headers);
      http.StreamedResponse streamedResponse = await request.send().timeout(timeout);
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
        'socket exception',
        name: 'RequestManager post function'.logRed,
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
