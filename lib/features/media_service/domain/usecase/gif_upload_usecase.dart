import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/model/gif_model.dart';
import '../repository/media_upload_repository.dart';

class GifUpload implements UseCase<GifUploadModelResponse, GifUploadParams> {
  final MediaUploadRepository mediaUploadRepository;

  GifUpload({required this.mediaUploadRepository});
  @override
  Future<Either<Failure, GifUploadModelResponse>> call(
    GifUploadParams params,
  ) {
    return mediaUploadRepository.uploadGif(params.getBody());
  }
}

class GifUploadParams {
  final String gifPath;

  Map<String, String> getBody() {
    return {
      "GIF": gifPath,
    };
  }

  GifUploadParams({required this.gifPath});
}
