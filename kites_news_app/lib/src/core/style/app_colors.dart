import 'package:flutter/material.dart';
import '../helper/helper.dart';

class AppColors {

 bool isDark =  Helper.isDarkTheme();

 Color get textColor => isDark ? Colors.white : Colors.black;
 Color get darkGray => isDark ? Colors.white : Color(0xFF808080);

  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const primaryColor = Color(0xFF1A1A1A);
  static const orange = Color(0xFFFF5433);
  static const lightGray = Color(0xFFdddddd);
  static const gray = Color(0xFF9A9A9A);
  static const red = Color(0xFFD32F2F);
  static const transparent = Colors.transparent;
  static const cardLightBg = Color(0xffD0DDD0);
  static const cardDarkBg = Color(0xff2F3E35);


}
