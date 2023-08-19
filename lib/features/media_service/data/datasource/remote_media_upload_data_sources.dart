import '../../../../core/unified_api/api_variables.dart';
import '../../../../core/unified_api/methods/multi_post_api.dart';
import '../model/gif_model.dart';
import '../model/image_model.dart';
import '../model/video_model.dart';

class RemoteMediaUploadDataSources {
  Future<ImageUploadResponseModel> imageUpload(Map<String, String> body) async {
    MultiPostApi api = MultiPostApi(
      body: body,
      fromJson: imageUploadResponseModelFromJson,
      uri: ApiVariables.uploadMedia(),
    );
    final result = await api();
    return result;
  }

  Future<VideoUploadModelResponse> videoUpload(Map<String, String> body) async {
    MultiPostApi api = MultiPostApi(
      uri: ApiVariables.uploadMedia(),
      body: body,
      timeout: const Duration(seconds: 360),
      fromJson: videoUploadModelResponseFromJson,
    );
    final result = await api();
    return result;
  }

  Future<GifUploadModelResponse> gifUpload(Map<String, String> body) async {
    MultiPostApi api = MultiPostApi(
      uri: ApiVariables.uploadMedia(),
      body: body,
      timeout: const Duration(seconds: 60),
      fromJson: gifUploadModelResponseFromJson,
    );
    final result = await api();
    return result;
  }
}
