import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/video_model.dart';
import '../repository/media_upload_repository.dart';

class VideoUpload
    implements UseCase<VideoUploadModelResponse, VideoUploadParams> {
  final MediaUploadRepository mediaUploadRepository;

  VideoUpload({required this.mediaUploadRepository});

  @override
  Future<Either<Failure, VideoUploadModelResponse>> call(
      VideoUploadParams params) async {
    return mediaUploadRepository.uploadVideo(params.getBody());
  }
}

class VideoUploadParams {
  final String videoPath;
  Map<String, String> getBody() {
    return {
      "video": videoPath,
    };
  }

  VideoUploadParams({
    required this.videoPath,
  });
}
