import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mealmate/core/ui/toaster.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/auth/data/models/user_model.dart';
import '../extensions/colorful_logging_extension.dart';
import '../ui/theme/colors.dart';
import 'prefs_keys.dart';

part 'image_helper.dart';

class Helper {
  Helper._();

  ////////////////////
  static String? _userToken;
  static String? get userToken => _userToken;
  static Future<void> setUserToken(String token) async {
    _userToken = token;
  }

  static Future<void> deleteUserToken() async {
    final sp = await SharedPreferences.getInstance();
    _userToken = null;
    sp.clear();
  }
  ////////////////////

  static Future<bool> isAuth() async {
    return _userToken != null || await isAuthSavedToStorage();
  }

  static Future<bool> isAuthSavedToStorage() async {
    final sp = await SharedPreferences.getInstance();
    return sp.containsKey(PrefsKeys.userInfo);
  }

  static void setUserDataToStorage(UserModel user) async {
    final sp = await SharedPreferences.getInstance();
    sp.setString(PrefsKeys.userInfo, userModelToJson(user));
    log("${sp.getString(PrefsKeys.userInfo)}".logWhite);
  }

  static Future<String?> getTokenFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    String? token = userModelFromJson(sp.getString(PrefsKeys.userInfo) ?? '{}').tokenInfo?.token;
    return token;
  }

  static void removeUserInfoFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    sp.remove(PrefsKeys.userInfo);
  }

  static Future<bool> isFirstTimeOpeningApp() async {
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey(PrefsKeys.showOnBorder)) {
      sp.setBool(PrefsKeys.showOnBorder, true);
      return true;
    } else {
      return sp.getBool(PrefsKeys.showOnBorder)!;
    }
  }

  static void setNotFirstTimeOpeningApp() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(PrefsKeys.showOnBorder, false);
  }

  static Future<String> getFCMToken({bool getFCMToken = false}) async {
    late String token;
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(PrefsKeys.fcmToken) && !getFCMToken) {
      token = sp.getString(PrefsKeys.fcmToken)!;
    } else {
      token = (await FirebaseMessaging.instance.getToken())!;
      sp.setString(PrefsKeys.fcmToken, token);
    }

    log(token, name: 'FcmHelper ==> initFCM ==> fcm token');

    return token;
  }

  static Future<bool> launchWeb(String url) => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );

  static Future<File?> pickImage() async => await _ImageHelper.getImageAndCrop();

  static downloadImage(String url, {String? outputMimeType}) async {
    String? message;

    try {
      // Download image
      final http.Response response = await http.get(Uri.parse(url));

      // Get temporary directory
      final dir = await getTemporaryDirectory();

      // Get the image name
      final imageName = url.split('/').last;

      // Create an image name
      var filename = '${dir.path}/$imageName';

      // Save to filesystem
      final file = File(filename);
      await file.writeAsBytes(response.bodyBytes);

      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        message = 'downloaded successfully';
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      Toaster.showToast(message);
    }
  }

  // static Future<String?> getDeviceId() async {
  //   final deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isIOS) {
  //     final iosDeviceInfo = await deviceInfo.iosInfo;
  //     log(iosDeviceInfo.identifierForVendor!);
  //     return iosDeviceInfo.identifierForVendor;
  //   } else if (Platform.isAndroid) {
  //     final androidDeviceInfo = await deviceInfo.androidInfo;
  //     log(androidDeviceInfo.id, name: "androidDeviceId");
  //     return androidDeviceInfo.id;
  //   }
  //   return null;
  // }

  // static int getLengthWithLoading({
  //   required int itemCount,
  //   required int crossAxisCount,
  // }) {
  //   return itemCount + (crossAxisCount - (itemCount % crossAxisCount));
  // }
}
