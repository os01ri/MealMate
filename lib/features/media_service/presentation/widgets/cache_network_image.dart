// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:mealmate/features/media_service/presentation/widgets/video_viewer.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/media_type.dart';
import '../../../../core/ui/theme/colors.dart';
import '../../../../core/ui/widgets/gif_image.dart';
import '../pages/image_view_screen.dart';

class CachedNetworkImage extends StatefulWidget {
  const CachedNetworkImage({
    Key? key,
    required this.hash,
    required this.url,
    required this.width,
    required this.height,
    this.color = AppColors.orange,
    this.fit = BoxFit.fill,
    this.border,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
    this.isPush = false,
    this.topRightCornerText,
    this.topLeftCornerText,
    this.mediaUrl,
    this.controller,
    this.cacheKey,
    this.bottomLeftCornerText,
    this.mediaType = MediaTypeExtension.imageVal,
  }) : super(key: key);

  final String hash;
  final Color color;
  final String url;
  final BoxFit fit;
  final double width;
  final double height;
  final Border? border;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final bool isPush;
  final StreamController<bool>? controller;
  final String? topRightCornerText;
  final String? topLeftCornerText;
  final String? bottomLeftCornerText;
  final int mediaType;
  final String? mediaUrl, cacheKey;

  @override
  State<CachedNetworkImage> createState() => _CachedNetworkImageState();
}

class _CachedNetworkImageState extends State<CachedNetworkImage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      fit: widget.fit,
      cache: true,
      width: widget.width,
      height: widget.height,
      timeLimit: const Duration(seconds: 10),
      cacheKey: widget.cacheKey,
      timeRetry: const Duration(seconds: 10),
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                shape: widget.shape,
                border: widget.border,
                borderRadius: widget.borderRadius,
              ),
              child: ClipRRect(
                borderRadius: (widget.borderRadius != null)
                    ? widget.borderRadius!.resolve(Directionality.of(context)) - BorderRadius.circular(2)
                    : widget.shape == BoxShape.circle
                        ? BorderRadius.circular(100)
                        : BorderRadius.circular(15 - 2),
                child: widget.hash != 'o'
                    ? BlurHash(
                        hash: widget.hash,
                      )
                    : Shimmer.fromColors(
                        baseColor: AppColors.grey,
                        highlightColor: AppColors.grey2,
                        child: SizedBox(
                          width: widget.width,
                          height: widget.height,
                          child: Image.asset('assets/png/loading_points_image.png'),
                        ),
                      ),
              ),
            );
          case LoadState.failed:
            return GestureDetector(
              onTap: () => state.reLoadImage(),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  shape: widget.shape,
                  border: widget.border,
                  borderRadius: widget.borderRadius,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: (widget.borderRadius != null)
                          ? widget.borderRadius!.resolve(Directionality.of(context)) - BorderRadius.circular(2)
                          : widget.shape == BoxShape.circle
                              ? BorderRadius.circular(100)
                              : BorderRadius.circular(15 - 2),
                      child: BlurHash(hash: widget.hash),
                    ),
                    const Center(
                      child: Icon(
                        Icons.replay_circle_filled_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          case LoadState.completed:
            if (widget.controller != null) {
              widget.controller!.add(true);
            }
            return GestureDetector(
              onTap: widget.isPush ? () => openMedia(state) : null,
              child: Stack(
                children: [
                  Container(
                    width: widget.width,
                    height: widget.height,
                    decoration: BoxDecoration(
                      shape: widget.shape,
                      border: widget.border,
                      borderRadius: widget.borderRadius,
                      image: DecorationImage(
                        image: state.imageProvider,
                        fit: widget.fit,
                      ),
                    ),
                  ),
                  widget.mediaType == MediaType.video.value
                      ? Container(
                          alignment: Alignment.center,
                          margin: EdgeInsetsDirectional.only(start: widget.width / 2 - widget.width / 8),
                          width: widget.width / 8,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(.5),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_circle,
                              color: AppColors.grey,
                              size: widget.width / 9,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            );
          default:
            return GestureDetector(
              onTap: () => state.reLoadImage(),
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  shape: widget.shape,
                  border: widget.border,
                  borderRadius: widget.borderRadius,
                  color: widget.color.withOpacity(.8),
                ),
                child: const Icon(
                  Icons.replay_circle_filled_sharp,
                  color: Colors.white,
                ),
              ),
            );
        }
      },
    );
  }

  void openMedia(ExtendedImageState state) async {
    switch (widget.mediaType) {
      case MediaTypeExtension.imageVal:
        openImage(state.imageProvider);
        break;
      case MediaTypeExtension.videoVal:
        openVideo();
        break;
      case MediaTypeExtension.gifVal:
        await openGIF();
        break;
      default:
    }
  }

  void openImage(ImageProvider imageProvider) {
    Navigator.of(context).pushNamed(
      ImageViewScreen.routeName,
      arguments: ImageViewScreenParams(
        imageProvider: imageProvider,
        imageUrl: widget.url,
        bottomLeftCornerText: widget.bottomLeftCornerText,
        topLeftCornerText: widget.topLeftCornerText,
        topRightCornerText: widget.topRightCornerText,
      ),
    );
  }

  void openVideo() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      barrierColor: Colors.transparent,
      barrierLabel: 'Video View',
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.2, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
      pageBuilder: (_, __, ___) {
        return GestureDetector(
          onVerticalDragEnd: (val) {
            if (val.primaryVelocity! > 0) {
              Navigator.of(context).pop();
            }
          },
          child: VideoViewer(
            url: widget.mediaUrl!,
            hash: widget.hash,
          ),
        );
      },
    );
  }

  Future<void> openGIF() async {
    FlutterGifController gifController = FlutterGifController(
      vsync: this,
      duration: const Duration(seconds: 30),
      value: 0,
    );

    final imageProvider = NetworkImage(widget.mediaUrl!);
    final info = await fetchGif(imageProvider);
    var d = info.length * .05;
    gifController.repeat(
      min: 0,
      max: info.length.toDouble(),
      period: Duration(
        seconds: d.ceil(),
      ),
    );

    showGeneralDialog(
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.2, end: 1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInCubic,
            ),
          ),
          child: child,
        );
      },
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      barrierColor: Colors.transparent,
      barrierLabel: 'Gif View',
      pageBuilder: (_, __, ___) {
        return Scaffold(
          body: Center(
            child: GestureDetector(
              onVerticalDragEnd: (val) {
                if (val.primaryVelocity! > 0) {
                  Navigator.of(context).pop();
                }
              },
              child: SizedBox(
                height: double.infinity,
                child: GifImage(image: imageProvider, controller: gifController),
              ),
            ),
          ),
        );
      },
    ).whenComplete(() => gifController.dispose());
  }
}
