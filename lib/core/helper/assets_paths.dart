class SvgPath {
  SvgPath._();
  static const _mainPath = 'assets/svg/';

  ///SVGs///
  static const introSvg = '${_mainPath}intro.svg';
  static const orderSvg = '${_mainPath}shop_active.svg';

  static const defaultImage =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSZeAxmjEiBWqDFmnAq7cvlXRWq_WaaEBVyDolxUAZ0l-B9w4rAAotFfqIVWi1B9l6UBc&usqp=CAU';
  static const defaultHash = 'LPODnIj[~qof-;fQM{fQoffQM{ay';
}

class PngPath {
  PngPath._();
  static const _mainPath = 'assets/png/';
  static const _iconsPath = 'assets/icons/';

  ///PNGs///
  static const intro1 = '${_mainPath}intro1.png';
  static const intro2 = '${_mainPath}intro2.png';
  static const intro3 = '${_mainPath}intro3.png';
  static const accountCreation = '${_mainPath}account_creation.png';
  static const food = '${_mainPath}food2.png';
  static const user = '${_mainPath}user.png';

  ///icons///
  static const saveInactive = '${_iconsPath}inactive_save.png';
  static const saveActive = '${_iconsPath}active_save.png';
}
