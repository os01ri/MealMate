import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/unified_api/handling_exception_manager.dart';
import '../../domain/repository/media_upload_repository.dart';
import '../datasource/remote_media_upload_data_sources.dart';
import '../model/gif_model.dart';
import '../model/image_model.dart';
import '../model/video_model.dart';

class MediaUploadRepositoriesImplement with HandlingExceptionManager implements MediaUploadRepository {
  final _uploadMedia = RemoteMediaUploadDataSources();
  @override
  Future<Either<Failure, ImageUploadResponseModel>> uploadImage(Map<String, String> body) async {
    return wrapHandling(tryCall: () async {
      final result = await _uploadMedia.imageUpload(body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, VideoUploadModelResponse>> uploadVideo(Map<String, String> body) async {
    return wrapHandling(tryCall: () async {
      final result = await _uploadMedia.videoUpload(body);
      return Right(result);
    });
  }

  @override
  Future<Either<Failure, GifUploadModelResponse>> uploadGif(Map<String, String> body) async {
    return wrapHandling(tryCall: () async {
      final result = await _uploadMedia.gifUpload(body);
      return Right(result);
    });
  }
}
