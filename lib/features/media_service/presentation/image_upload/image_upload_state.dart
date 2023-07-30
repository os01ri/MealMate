part of 'image_upload_bloc.dart';

enum ImageUploadStatus { init, succ, loading, failed }

class ImageUploadState {
  final ImageUploadStatus status;
  final String mediaName;
  final File? media;

  const ImageUploadState({
    this.mediaName = '',
    this.status = ImageUploadStatus.init,
    this.media,
  });

  ImageUploadState copyWith({
    ImageUploadStatus? status,
    String? mediaName,
    File? media,
    bool removeMedia = false,
  }) {
    return ImageUploadState(
      status: status ?? this.status,
      mediaName: mediaName ?? this.mediaName,
      media: (removeMedia) ? null : media ?? this.media,
    );
  }
}
