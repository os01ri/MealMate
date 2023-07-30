// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/ui/theme/colors.dart';
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
              child: Container(
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
    openImage(state.imageProvider);
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
}
