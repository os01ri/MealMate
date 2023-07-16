import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/image_model.dart';
import '../repository/media_upload_repository.dart';

class ImageUpload implements UseCase<ImageUploadResponseModel, ImageUploadParams> {
  final MediaUploadRepository mediaUploadRepository;

  ImageUpload({required this.mediaUploadRepository});
  @override
  Future<Either<Failure, ImageUploadResponseModel>> call(ImageUploadParams params) {
    return mediaUploadRepository.uploadImage(params.getParams());
  }
}

class ImageUploadParams {
  final File media;
  ImageUploadParams({required this.media});
  Map<String, String> getParams() {
    return {
      'image': media.path,
    };
  }
}
