import 'package:intl/intl.dart' as intl;

extension NumberExtension on int {
  String numberFormat() => intl.NumberFormat(',###' * 10).format(this);
}
