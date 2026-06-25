import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromString(hexColor));

  static _getColorFromString(String hexColor) {
    if (hexColor == null || hexColor.isEmpty) {
      return int.parse('ffffffff', radix: 16);
    }

    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
