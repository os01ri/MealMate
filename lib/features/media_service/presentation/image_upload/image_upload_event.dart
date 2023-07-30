part of 'image_upload_bloc.dart';

abstract class ImageUploadEvent {
  const ImageUploadEvent();
}

class GoImageUploadEvent extends ImageUploadEvent {
  const GoImageUploadEvent();
}

class SetImageEvent extends ImageUploadEvent {
  final File media;
  final bool isUploaded;
  
  const SetImageEvent({
    required this.media,
    this.isUploaded = false,
  });
}

class RemoveImageEvent extends ImageUploadEvent {}
