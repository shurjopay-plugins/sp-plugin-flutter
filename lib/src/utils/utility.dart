import "package:flutter/cupertino.dart";

class Utility {
  static String getString(dynamic value) {
    if (value is int) {
      return value.toString();
    } else {
      return value;
    }
  }

  static int getInt(dynamic value) {
    if (value is String) {
      return int.parse(value);
    } else {
      return value;
    }
  }

  static double getDouble(dynamic value) {
    if (value is String) {
      return double.parse(value);
    } else {
      return value.toDouble();
    }
  }
}
