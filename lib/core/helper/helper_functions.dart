import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/auth/domain/entities/user.dart';
import '../ui/theme/colors.dart';
import 'prefs_keys.dart';

part 'image_helper.dart';

class HelperFunctions {
  HelperFunctions._();

  static Future<bool> isAuth() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.containsKey(PrefsKeys.userInfo);
  }

  static Future<void> setUserData(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(PrefsKeys.userInfo, userModelToJson(user));
    log("${sp.getString(PrefsKeys.userInfo)}");
  }

  static Future<bool> isFirstTime() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (!sp.containsKey(PrefsKeys.isShowOnBorder)) {
      sp.setBool(PrefsKeys.isShowOnBorder, true);
      return true;
    }

    return false;
  }

  static Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token =
        userModelFromJson(sp.getString(PrefsKeys.userInfo) ?? '{}').token;
    return token;
  }

  static Future<String> getFCMToken({bool getFCMToken = false}) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    late String token;

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
