part of 'image_upload_bloc.dart';

enum ImageUploadStatus {
  init,
  succ,
  loading,
  failed,
}

class ImageUploadState {
  final ImageUploadStatus status;
  final String mediaName;
  final File? media;
  final int mediaType;
  const ImageUploadState({
    this.mediaName = '',
    this.status = ImageUploadStatus.init,
    this.media,
    this.mediaType = MediaTypeExtension.imageVal,
  });
  ImageUploadState copyWith({
    ImageUploadStatus? status,
    String? mediaName,
    File? media,
    int? mediaType,
    bool removeMedia = false,
  }) {
    return ImageUploadState(
      status: status ?? this.status,
      mediaType: mediaType ?? this.mediaType,
      mediaName: mediaName ?? this.mediaName,
      media: (removeMedia) ? null : media ?? this.media,
    );
  }
}
