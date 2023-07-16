import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mealmate/core/extensions/string_extensions.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  const VideoViewer({
    Key? key,
    required this.url,
    required this.hash,
    this.streamController,
    this.isFile = false,
    this.aspectRatio,
    this.value,
    this.volume,
  }) : super(key: key);

  final StreamController<bool>? streamController;
  final double? volume;

  ///the hash that will be behind the video
  final String hash;
  final String url;
  final double? aspectRatio;
  final ValueNotifier<double>? value;
  final bool isFile;
  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late ChewieController chewieController;
  late Stream<bool>? isPaused;
  ValueNotifier<bool> notifier = ValueNotifier(false);
  @override
  void dispose() {
    super.dispose();
    chewieController.videoPlayerController.dispose();
    chewieController.dispose();
  }

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController:
          widget.isFile ? VideoPlayerController.file(File(widget.url)) : VideoPlayerController.network(widget.url),
      placeholder: BlurHash(hash: widget.hash),
      autoPlay: true,
      isLive: false,
      looping: widget.volume != null,
      aspectRatio: widget.aspectRatio,
      showControls: false,
    );
    if (widget.volume != null) {
      chewieController.videoPlayerController.setVolume(widget.volume!);
    }
    if (!widget.isFile) {
      () async {
        FileInfo? file;
        file = await DefaultCacheManager().getFileFromCache(
          widget.url.getMediaName(),
        );
        if (file != null) {
          setState(() {
            chewieController.videoPlayerController.dispose();
            chewieController = chewieController.copyWith(videoPlayerController: VideoPlayerController.file(file!.file));
          });
        } else {
          DefaultCacheManager().downloadFile(widget.url, key: widget.url.getMediaName());
        }
      }();
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurHash(hash: widget.hash),
        Padding(
          padding: widget.aspectRatio == null ? const EdgeInsets.all(8.0) : EdgeInsets.zero,
          child: Chewie(controller: chewieController),
        ),
      ],
    );
  }
}
