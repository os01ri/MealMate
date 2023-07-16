import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../../dependency_injection.dart';
import '../extensions/colorful_logging_extension.dart';
import '../localization/localization_class.dart';
import '../ui/theme/colors.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../services/shared_preferences_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../ui/ui_messages.dart';
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
    _userToken = null;
    SharedPreferencesService.sp.clear();
  }
  ////////////////////

  static Future<bool> isAuth() async {
    return _userToken != null || isAuthSavedToStorage();
  }

  static bool isAuthSavedToStorage() {
    return SharedPreferencesService.sp.containsKey(PrefsKeys.userInfo) && getTokenFromStorage() != null;
  }

  static void setUserDataToStorage(UserModel user) {
    SharedPreferencesService.sp.setString(PrefsKeys.userInfo, userModelToJson(user));
    log("${SharedPreferencesService.sp.getString(PrefsKeys.userInfo)}".logWhite);
  }

  static String? getTokenFromStorage() {
    String? token = userModelFromJson(
      SharedPreferencesService.sp.getString(PrefsKeys.userInfo) ?? '{}',
    ).tokenInfo?.token;
    return token;
  }

  static void removeUserInfoFromStorage() {
    SharedPreferencesService.sp.remove(PrefsKeys.userInfo);
  }

  static Future<bool> isFirstTimeOpeningApp() async {
    if (!SharedPreferencesService.sp.containsKey(PrefsKeys.showOnBorder)) {
      SharedPreferencesService.sp.setBool(PrefsKeys.showOnBorder, true);
      return true;
    } else {
      return SharedPreferencesService.sp.getBool(PrefsKeys.showOnBorder)!;
    }
  }

  static void setNotFirstTimeOpeningApp() async {
    await SharedPreferencesService.sp.setBool(PrefsKeys.showOnBorder, false);
  }

  static Future<String> getFCMToken({bool getFCMToken = false}) async {
    late String token;

    if (SharedPreferencesService.sp.containsKey(PrefsKeys.fcmToken) && !getFCMToken) {
      token = SharedPreferencesService.sp.getString(PrefsKeys.fcmToken)!;
    } else {
      token = (await FirebaseMessaging.instance.getToken())!;
      SharedPreferencesService.sp.setString(PrefsKeys.fcmToken, token);
    }

    log(token, name: 'FcmHelper ==> initFCM ==> fcm token');

    return token;
  }

  static Future<bool> launchWeb(String url) => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalNonBrowserApplication,
      );

  static Future<File?> pickImage() async => await _ImageHelper.getImageAndCrop();


  static Future downloadImage(String url, {String? outputMimeType}) async {
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
        message = serviceLocator<LocalizationClass>().appLocalizations!.yes;
      }
    } catch (e) {
      message = 'An error occurred while saving the image';
    }

    if (message != null) {
      Toaster.showToast(message);
    }
  }

  static Future<File?> getImageWithCrop({
    required CropAspectRatio aspectRatio,
  }) async {
    const status = Permission.manageExternalStorage;
    await Permission.manageExternalStorage.request();
    if ((await status.isDenied)) {
      await Permission.manageExternalStorage.request();
    }
    File? image;
    final FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        "jpeg",
        "png",
        "jpg",
        "svg",
      ],
    );
    if (filePickerResult != null) {
      final imageCropper = await ImageCropper()
          .cropImage(sourcePath: filePickerResult.files.first.path!, aspectRatio: aspectRatio, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: AppColors.orange,
          toolbarWidgetColor: AppColors.grey2,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
          aspectRatioLockEnabled: true,
        ),
      ]);
      if (imageCropper != null) {
        image = File(imageCropper.path);
      }
    }
    return image;
  }

  static Future<File?> getGif() async {
    const status = Permission.manageExternalStorage;
    await Permission.manageExternalStorage.request();
    if ((await status.isDenied)) {
      await Permission.manageExternalStorage.request();
    }
    final FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["gif"],
    );
    File? gif;
    if (filePickerResult != null) {
      gif = File(filePickerResult.files.first.path!);
    }
    return gif;
  }

  static Future<File?> getVideo() async {
    const status = Permission.manageExternalStorage;
    await Permission.manageExternalStorage.request();
    if ((await status.isDenied)) {
      await Permission.manageExternalStorage.request();
    }
    final FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["mp4"],
    );
    File? video;
    if (filePickerResult != null) {
      video = File(filePickerResult.files.first.path!);
    }
    return video;
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
