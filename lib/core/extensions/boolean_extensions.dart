extension BoolToInteger on bool {
  int boolToInt() => this ? 1 : 0;
}

extension IntegerToBool on int {
  bool intToBool() => (this != 0);
}
