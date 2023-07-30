import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import '../../data/repository/media_upload_repositories_implement.dart';
import '../../domain/usecase/gif_upload_usecase.dart';
import '../../domain/usecase/image_upload_usecase.dart';
import '../../domain/usecase/video_upload_usecase.dart';

part 'image_upload_event.dart';
part 'image_upload_state.dart';

class ImageUploadBloc extends Bloc<ImageUploadEvent, ImageUploadState> {
  final imageUpload = ImageUpload(mediaUploadRepository: MediaUploadRepositoriesImplement());
  final videoUpload = VideoUpload(mediaUploadRepository: MediaUploadRepositoriesImplement());
  final gifUpload = GifUpload(mediaUploadRepository: MediaUploadRepositoriesImplement());

  ImageUploadBloc() : super(const ImageUploadState()) {
    on<SetImageEvent>((event, emit) {
      emit(state.copyWith(
        media: event.media,
      ));
      if (!event.isUploaded) add(const GoImageUploadEvent());
    }, transformer: droppable());
    on<RemoveImageEvent>((event, emit) {
      emit(state.copyWith(
        removeMedia: true,
        status: ImageUploadStatus.init,
      ));
    });
    on<GoImageUploadEvent>(_mapGoImageUploadState, transformer: droppable());
  }

  FutureOr<void> _mapGoImageUploadState(
    GoImageUploadEvent event,
    Emitter<ImageUploadState> emit,
  ) async {
    emit(state.copyWith(
      status: ImageUploadStatus.loading,
    ));

    final result = await imageUpload(ImageUploadParams(
      media: state.media!,
    ));

    result.fold(
      (l) => emit(state.copyWith(
        status: ImageUploadStatus.failed,
      )),
      (r) => emit(state.copyWith(
        mediaName: r.data!.first.url,
        status: ImageUploadStatus.succ,
      )),
    );
  }
}
