// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mealmate/features/media_service/presentation/widgets/cache_network_image.dart';

import '../../../../core/helper/helper.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/theme/text_styles.dart';
import '../../../../core/ui/widgets/gif_image.dart';
import '../../data/model/media_model.dart';
import '../image_upload/image_upload_bloc.dart';

enum CropperRatio { square, verticalRectangle, horizontalRectangle }

class ImageSetterForm extends StatefulWidget {
  const ImageSetterForm({
    Key? key,
    required this.title,
    required this.onSuccess,
    this.numberOfTheImage,
    this.onPickingFinished,
    this.onRemove,
    this.loadingColor = AppColors.orange,
    this.borderColor = AppColors.orange,
    this.heightFactor,
    this.widthFactor,
    this.cropperRatio = CropperRatio.horizontalRectangle,
    this.mediaModelNotifier,
    this.bloc,
    this.file,
    this.isUploaded = false,
  }) : super(key: key);

  final String title;
  final int? numberOfTheImage;
  final Function(String) onSuccess;
  final Function(File)? onPickingFinished;
  final VoidCallback? onRemove;
  final Color loadingColor;
  final Color borderColor;
  final double? heightFactor;
  final double? widthFactor;
  final CropperRatio cropperRatio;
  final ValueNotifier<MediaModel?>? mediaModelNotifier;
  final ImageUploadBloc? bloc;
  final File? file;
  final bool isUploaded;

  @override
  State<ImageSetterForm> createState() => _ImageSetterFormState();
}

class _ImageSetterFormState extends State<ImageSetterForm> {
  //
  late final CropAspectRatio cropAspectRatio;
  late final double widthFactor;
  late final double heightFactor;

  @override
  void initState() {
    super.initState();

    cropAspectRatio = (widget.cropperRatio == CropperRatio.horizontalRectangle)
        ? const CropAspectRatio(ratioX: 2, ratioY: 1)
        : (widget.cropperRatio == CropperRatio.verticalRectangle)
            ? const CropAspectRatio(ratioX: 1, ratioY: 1.7)
            : const CropAspectRatio(ratioX: 1, ratioY: 1);

    widthFactor = widget.widthFactor ??
        ((widget.cropperRatio == CropperRatio.square || widget.cropperRatio == CropperRatio.verticalRectangle)
            ? .4
            : .8);

    heightFactor = widget.heightFactor ??
        ((widget.cropperRatio == CropperRatio.square || widget.cropperRatio == CropperRatio.horizontalRectangle)
            ? .4
            : .68);
  }

  Widget networkOrUserMedia() {
    bool isNetWorkMedia = widget.mediaModelNotifier != null && widget.mediaModelNotifier!.value != null;

    if (isNetWorkMedia) {
      return _NetworkMedia(
        mediaModelNotifier: widget.mediaModelNotifier!,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        onRemove: widget.onRemove,
        borderColor: widget.borderColor,
      );
    } else {
      return _UserSettingMedia(
        onSuccess: widget.onSuccess,
        bloc: widget.bloc,
        title: widget.title,
        isUploaded: widget.isUploaded,
        file: widget.file,
        loadingColor: widget.loadingColor,
        onRemove: widget.onRemove,
        onPickingFinished: widget.onPickingFinished,
        cropAspectRatio: cropAspectRatio,
        widthFactor: widthFactor,
        heightFactor: heightFactor,
        borderColor: widget.borderColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ValueListenableBuilder<MediaModel?>(
      valueListenable: widget.mediaModelNotifier ?? ValueNotifier(null),
      builder: (context, value, _) {
        return Stack(
          children: [
            networkOrUserMedia(),
            if (widget.numberOfTheImage != null)
              Center(
                child: Text(
                  '${widget.numberOfTheImage!}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        blurRadius: size.width * .05,
                      ),
                      Shadow(
                        color: Colors.black,
                        blurRadius: size.width * .05,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _NetworkMedia extends StatefulWidget {
  const _NetworkMedia({
    Key? key,
    required this.mediaModelNotifier,
    required this.widthFactor,
    required this.heightFactor,
    required this.borderColor,
    this.onRemove,
  }) : super(key: key);

  final Color borderColor;
  final VoidCallback? onRemove;
  final ValueNotifier<MediaModel?> mediaModelNotifier;
  final double widthFactor;
  final double heightFactor;

  @override
  State<_NetworkMedia> createState() => _NetworkMediaState();
}

class _NetworkMediaState extends State<_NetworkMedia> with TickerProviderStateMixin {
  List<ImageInfo> infos = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: .8),
      child: DottedBorder(
        radius: const Radius.circular(15),
        padding: EdgeInsets.zero,
        dashPattern: const [8, 6],
        borderType: BorderType.RRect,
        color: widget.borderColor,
        strokeWidth: size.width * .01,
        child: Container(
          width: size.width * widget.widthFactor,
          height: size.width * widget.heightFactor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                url: widget.mediaModelNotifier.value!.mediaUrl!,
                hash: widget.mediaModelNotifier.value!.hash!,
                borderRadius: BorderRadius.circular(15),
                width: size.width * widget.widthFactor,
                height: size.width * widget.heightFactor,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: size.width * .01,
                left: size.width * .01,
                child: GestureDetector(
                  onTap: () {
                    if (widget.onRemove != null) {
                      widget.onRemove!();
                    }
                    widget.mediaModelNotifier.value = null;
                  },
                  child: Container(
                    width: size.width * .068,
                    height: size.width * .068,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: size.width * .05,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserSettingMedia extends StatefulWidget {
  const _UserSettingMedia({
    Key? key,
    required this.onSuccess,
    required this.title,
    required this.cropAspectRatio,
    required this.widthFactor,
    required this.heightFactor,
    required this.borderColor,
    this.loadingColor = AppColors.orange,
    this.onPickingFinished,
    this.onRemove,
    this.bloc,
    this.file,
    this.isUploaded = false,
  }) : super(key: key);

  final File? file;
  final bool isUploaded;
  final ImageUploadBloc? bloc;
  final Function(String) onSuccess;
  final VoidCallback? onRemove;
  final Function(File)? onPickingFinished;
  final String title;
  final Color loadingColor;
  final Color borderColor;
  final CropAspectRatio cropAspectRatio;
  final double widthFactor;
  final double heightFactor;

  @override
  State<_UserSettingMedia> createState() => _UserSettingMediaState();
}

class _UserSettingMediaState extends State<_UserSettingMedia> with TickerProviderStateMixin {
  late ImageUploadBloc imageUploadBloc;
  late FlutterGifController gifController;
  late List<ImageInfo> infos;

  @override
  void initState() {
    imageUploadBloc = widget.bloc ?? ImageUploadBloc();

    final outFileSuccess = widget.file != null && imageUploadBloc.state.status != ImageUploadStatus.succ;

    if (outFileSuccess) {
      imageUploadBloc.add(
        SetImageEvent(
          media: widget.file!,
          isUploaded: widget.isUploaded,
        ),
      );
    }

    super.initState();
  }

  @override
  void dispose() {
    gifController.dispose();
    if (widget.bloc == null) {
      imageUploadBloc.close();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    gifController = FlutterGifController(
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
      duration: const Duration(seconds: 2),
    );

    gifController.addListener(() {
      if (gifController.value.ceil() == infos.length) {
        gifController.stop();
      }
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appLocalizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: .8),
      child: BlocProvider.value(
        value: imageUploadBloc,
        child: BlocConsumer<ImageUploadBloc, ImageUploadState>(
          listener: (context, state) async {
            if (state.status == ImageUploadStatus.failed) {
              BotToast.showText(text: appLocalizations.error);
            }
            if (state.status == ImageUploadStatus.succ) {
              widget.onSuccess(state.mediaName);
            }
          },
          builder: (context, state) {
            return (state.media == null)
                ? GestureDetector(
                    onTap: () async {
                      Helper.pickImage().then(
                        (value) {
                          if (value != null) {
                            if (widget.onPickingFinished != null) {
                              widget.onPickingFinished!(value);
                            }
                            if (widget.file != null || widget.bloc == null) {
                              imageUploadBloc.add(SetImageEvent(
                                media: value,
                                // mediaType: widget.mediaType!,
                              ));
                            }
                          }
                        },
                      );
                    },
                    child: DottedBorder(
                      radius: const Radius.circular(15),
                      padding: EdgeInsets.zero,
                      dashPattern: const [8, 6],
                      borderType: BorderType.RRect,
                      color: widget.borderColor,
                      strokeWidth: size.width * .005,
                      child: Container(
                        width: size.width * widget.widthFactor,
                        height: size.width * widget.heightFactor,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: AppTextStyles.styleWeight400(
                              fontSize: size.width * .04,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : DottedBorder(
                    radius: const Radius.circular(15),
                    padding: EdgeInsets.zero,
                    dashPattern: const [8, 6],
                    borderType: BorderType.RRect,
                    color: widget.borderColor,
                    strokeWidth: size.width * .01,
                    child: Container(
                      width: size.width * widget.widthFactor,
                      height: size.width * widget.heightFactor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.file(
                              widget.file ?? state.media!,
                              width: size.width * widget.widthFactor,
                              height: size.width * widget.heightFactor,
                              fit: BoxFit.cover,
                            ),
                          ),
                          (state.status == ImageUploadStatus.loading)
                              ? const Center(child: CircularProgressIndicator.adaptive())
                              : (state.status == ImageUploadStatus.failed)
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<ImageUploadBloc>().add(const GoImageUploadEvent());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(size.width * .015),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Icon(
                                            Icons.refresh_rounded,
                                            color: Theme.of(context).colorScheme.secondary,
                                            size: size.width * .065,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                          Positioned(
                            top: size.width * .01,
                            left: size.width * .01,
                            child: GestureDetector(
                              onTap: () {
                                imageUploadBloc.add(RemoveImageEvent());

                                if (widget.onRemove != null) {
                                  widget.onRemove!();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(size.width * .0075),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                  size: size.width * .05,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }

  Future<void> getMedia(int mediaType) async {
    // final media = (mediaType == MediaType.gif.value) ? await Helper.getGif() : await Helper.getVideo();
    // if (media != null) {
    //   imageUploadBloc.add(SetImageEvent(media: media));
    // }
  }
}
