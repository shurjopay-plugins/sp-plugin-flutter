class ValueParser {
  static String intToSring(dynamic value) {
    if (value is int) {
      return value.toString();
    } else {
      return value;
    }
  }

  static int stringToInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else {
      return value;
    }
  }

  static double stringToDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }
}
