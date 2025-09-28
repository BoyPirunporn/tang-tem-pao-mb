import 'package:flutter/material.dart';

class ColorConvert {
  static Color colorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // เพิ่มค่า alpha เป็น 0xFF (เต็ม)
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
