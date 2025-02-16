extension StringParser on String {
  String get svg => '$this.svg';
  String get jpeg => '$this.jpeg';
  String get jpg => '$this.jpg';
  String get png => '$this.png';
  String get json => '$this.json';

  String getMediaType() => split('/').last.split('.').last;

  String getMediaName() => split('/').last.split('.').first;
}
