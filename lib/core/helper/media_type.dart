enum MediaType { image, video, gif }

extension MediaTypeExtension on MediaType {
  static const int imageVal = 1;
  static const int videoVal = 2;
  static const int gifVal = 3;

  int get value {
    switch (this) {
      case MediaType.image:
        return imageVal;
      case MediaType.video:
        return videoVal;
      case MediaType.gif:
        return gifVal;
    }
  }
}
