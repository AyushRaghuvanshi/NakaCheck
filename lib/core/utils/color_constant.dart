import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color yellow800 = fromHex('#f89e31');

  static Color gray900 = fromHex('#121212');

  static Color red300 = fromHex('#cf6679');

  static Color whiteA700 = fromHex('#ffffff');

  static Color pink3003f = fromHex('#3fd9519d');

  static Color gray100 = fromHex('#f1f4f6');

  static Color switchGreen = fromHex('#76ee59');

  static Color boxBackBlack = fromHex('#1F1F24');

  static Color boxArrowColor = fromHex('#C3c3c3');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
