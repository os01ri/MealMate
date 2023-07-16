import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/gif_model.dart';
import '../../data/model/image_model.dart';
import '../../data/model/video_model.dart';

abstract class MediaUploadRepository {
  Future<Either<Failure, ImageUploadResponseModel>> uploadImage(Map<String, String> body);

  Future<Either<Failure, VideoUploadModelResponse>> uploadVideo(Map<String, String> body);

  Future<Either<Failure, GifUploadModelResponse>> uploadGif(Map<String, String> body);
}
