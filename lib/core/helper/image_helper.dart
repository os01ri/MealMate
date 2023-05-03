part of 'helper_functions.dart';

class _ImageHelper {
  _ImageHelper._();

  static Future<File?> getImageAndCrop({
    CropAspectRatio aspectRatio = const CropAspectRatio(ratioX: 4, ratioY: 4),
  }) async {
    await _requestPermission();

    File? image;

    final XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (xFile != null) {
      final result = await _crop(file: xFile, aspectRatio: aspectRatio);
      if (result != null) image = result;
    }

    return image;
  }

  static Future<void> _requestPermission() async {
    const status = Permission.manageExternalStorage;
    if ((await status.isDenied)) {
      _requestPermission();
    }
  }

  static Future<File?> _crop({
    required XFile file,
    required CropAspectRatio aspectRatio,
  }) async {
    final imageCropper = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: aspectRatio,
      uiSettings: [
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
      ],
    );

    if (imageCropper != null) {
      return File(imageCropper.path);
    }
    return null;
  }
}
